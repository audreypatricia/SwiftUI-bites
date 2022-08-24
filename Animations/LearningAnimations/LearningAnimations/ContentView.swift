//
//  ContentView.swift
//  LearningAnimations
//
//  Created by Audrey Patricia on 24/8/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        
        // MARK: - Implicit Animations
        ///  always need to watch a particular value
        /// value (in .animation) here is the value being observed for changes
        
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default, value: animationAmount)
        
        /// customise animation type by changing .default to something like .easeOut
        //            .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
        //            .animation(
        //                .easeInOut(duration: 2)
        //                .repeatCount(3, autoreverses: true),
        //                .delay(1),
        //                value: animationAmount
        //            )
        
        /// .animation() creates an instance of Animation struct, which has its own modifiers like .delay()
        
        Button("Tap Me") {
            // animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
