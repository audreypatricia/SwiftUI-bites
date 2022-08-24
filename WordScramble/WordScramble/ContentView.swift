//
//  ContentView.swift
//  WordScramble
//
//  Created by Audrey Patricia on 16/8/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var totalScore: Int = 0
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard answer != rootWord else {
            displayError(title: "Word matches the start word", message: "Don't cheat!")
            return
        }
        
        guard isAtLeastThreeLetters(word: answer) else {
            displayError(title: "Word to short", message: "Try forming longer words")
            return
        }
        
        guard isOriginal(word: answer) else {
            displayError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            displayError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            displayError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        calculateScore(word: answer)
        newWord = ""
    }
    
    func startGame() {
        totalScore = 0
        usedWords = []
        
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isAtLeastThreeLetters(word: String) -> Bool {
        return word.count >= 3
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func displayError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func calculateScore(word: String) {
        let score = (word.count) * 2
        totalScore += score
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(rootWord)
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                    
                    Section("Total Score") {
                        Text(String(totalScore))
                    }
                }
                .listStyle(GroupedListStyle())
            }
        }
        .navigationTitle(rootWord)
        .toolbar(content: {
            ToolbarItem(placement: .bottomBar) {
                Button("New Game", action: startGame)
            }
        })
        .onSubmit(addNewWord)
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel){}
        } message: {
            Text(errorMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
