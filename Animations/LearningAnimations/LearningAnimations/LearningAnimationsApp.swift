//
//  LearningAnimationsApp.swift
//  LearningAnimations
//
//  Created by Audrey Patricia on 24/8/2022.
//

import SwiftUI

@main
struct LearningAnimationsApp: App {
    var body: some Scene {
        WindowGroup {
//            ImplicitAnimations()
            AnimationBinding()
//            ExplicitAnimation()
        }
    }
}

/// Three ways of creating animations
/// 1) implicit animations: binding animation() modifier to a view
/// 2) binding animations: create animated binding changes by adding the animation() modifier to a binding
/// 3) explicit animations: explicitly asking to animate changes occuring as the result of a state change
