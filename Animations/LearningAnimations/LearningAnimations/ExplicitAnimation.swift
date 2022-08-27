//
//  ExplicitAnimation.swift
//  LearningAnimations
//
//  Created by Audrey Patricia on 27/8/2022.
//

import Foundation
import SwiftUI

struct ExplicitAnimation: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 1))
    }
}

struct ExplicitAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimation()
    }
}
