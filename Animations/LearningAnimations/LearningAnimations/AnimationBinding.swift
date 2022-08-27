//
//  AnimationBindings.swift
//  LearningAnimations
//
//  Created by Audrey Patricia on 27/8/2022.
//

import Foundation
import SwiftUI

struct AnimationBinding: View {
    @State private var animationAmount = 1.0

    var body: some View {
        return VStack {
            Stepper(
                "Scale amount",
                value: $animationAmount
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)
                        // animated binding changes:
                        // this variant of animation() modifier doesn't need
                        // us to specify which value we are watching
                        // since it is literally attached to the value it should watch
                    ),
                in: 1...10
            )

            Spacer()

            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct AnimationBinding_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBinding()
    }
}
