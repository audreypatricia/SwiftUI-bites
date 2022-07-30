//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Audrey Patricia on 20/7/2022.
//

import SwiftUI

struct ContentView: View {
    var moves: [String] = ["Rock", "Paper", "Scissors"]
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin: Bool = true
    @State private var score: Int = 0
    @State private var showAlert: Bool = false
    @State private var questionNumber: Int = 1
    @State private var showingGameOver: Bool = false
    @State private var roundState: String = ""
    @State private var didTapWinButton: Bool = false
    @State private var didTapLoseButton: Bool = false
    
    func check(choice: String) {
        guard questionNumber != 10 else {
            showingGameOver = true
            return
        }
        
        if shouldWin {
            if (moves[computerChoice] == "Rock" && choice == "Paper") || (moves[computerChoice] == "Paper" && choice == "Scissors") || (moves[computerChoice] == "Scissors" && choice == "Rock") {
                score += 1
                roundState = "Correct"
            } else {
                roundState = "Wrong!"
            }
        } else {
            if(moves[computerChoice] == "Rock" && choice == "Scissors") || (moves[computerChoice] == "Paper" && choice == "Rock") || (moves[computerChoice] == "Scissors" && choice == "Paper") {
                score += 1
                roundState = "Correct"
            } else {
                roundState = "Wrong!"
            }
        }
        
        questionNumber += 1
        showAlert = true
    }
    
    func resetGame() {
        computerChoice = Int.random(in: 0..<3)
        score = 0
    }
    
    func nextRound() {
        computerChoice = Int.random(in: 0..<3)
        didTapWinButton = false
        didTapLoseButton = false
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
        
                Text("score: ")
                Text("\(score)")
                Spacer()
            }
            .font(.title.bold())

            Spacer()
            
            VStack {
                Text("Computer picks:")
                    .font(.title3)
               
                if moves[computerChoice] == "Rock" {
                    Text("🪨")
                        .font(.system(size: 50))
                } else if moves[computerChoice] == "Paper" {
                    Text("📄")
                        .font(.system(size: 50))
                } else {
                    Text("✂️")
                        .font(.system(size: 50))
                }
                
                VStack {
                    Text("What do you want to do?")
                        .font(.title3)
                        .padding()
                    
                    HStack {
                        Button("Win 🏆") {
                            shouldWin = true
                            didTapWinButton = true
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(didTapWinButton ? Color.white : Color.accentColor)
                        .background(didTapWinButton ? Color.accentColor : Color.gray.opacity(0.5))
                        
                        Button("Lose 😥") {
                            shouldWin = false
                            didTapLoseButton = true
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(didTapLoseButton ? Color.white : Color.accentColor)
                        .background(didTapLoseButton ? Color.yellow : Color.gray.opacity(0.5))
                    }
                }
            }
            
            Spacer()
            
            Text("What will you play?")
                .font(.title3)
            HStack {
                let buttons: [String] = ["Rock", "Paper", "Scissors"]
                
                ForEach(buttons, id: \.self) { label in
                    Button {
                        check(choice: label)
                    } label: {
                        Text(label)
                            .font(.largeTitle)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .alert("Game Over\n Total score is \(score)", isPresented: $showingGameOver) {
                Button("New game") {
                    resetGame()
                }
            }
        }
        .alert("\(roundState)", isPresented: $showAlert) {
            Button("Ok") {
                nextRound()
            }
        } message: {
            Text("Your score is \(score)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


