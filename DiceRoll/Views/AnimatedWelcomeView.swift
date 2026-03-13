//
//  AnimatedWelcomeView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 04/03/2026.
//

import SwiftUI

enum AnimPhases: CaseIterable {
    case start
    case throwRoll
    case roll
    case back
}

struct AnimatedWelcomeView: View {
    
    @State var animateToggle: Bool = false
    
    @State var scale: CGFloat = 1
    @State var rotation: Angle = .zero
    @State var offsetX: CGFloat = .zero
    
    @State var sides: Int = 6
    
    var result: Int {
        Int.random(in: 1...sides)
    }
    
    var body: some View {
        GradientBackground() {
            VStack {
                DiceView(sides: sides)
                    .phaseAnimator(AnimPhases.allCases, trigger: animateToggle) { content, phase in
                        content
                            .scaleEffect(phase == .throwRoll ? 1.5 : 1)
                            .rotationEffect(phase == .throwRoll ? .degrees(25) : .zero)
                            .rotationEffect(phase == .roll ? .degrees(50) : .zero)
                            .rotationEffect(phase == .back ? .degrees(360) : .zero)
                            .offset(x: phase == .back ? 300 : 0)
                    } animation: { phase in
                        switch phase {
                        case .back: .snappy(duration: 0.6)
                        default: .snappy(duration: 0.3).delay(0.5)
                        }
                    }
                
                Button("Click me") {
                    animateToggle.toggle()
                }
            }
        }
    }
    func runSequence() {
        withAnimation(.snappy(duration: 0.3)) {
            scale = 1.5
//            rotation = .degrees(25)
            animateToggle = true
        } completion: {
            withAnimation(.snappy(duration: 0.3)) {
                scale = 1
                rotation = .degrees(45)
            } completion: {
                withAnimation(.snappy(duration: 0.3)) {
                    rotation = .degrees(360)
                    offsetX = 300
                } completion: {
                    withAnimation(.snappy(duration: 0.5)) {
                        rotation = .zero
                        offsetX = .zero
                        sides = Int.random(in: 1...6)
                        
                    } completion: {
                        animateToggle = false
                    }
                }
            }
        }
    }
}

#Preview {
    AnimatedWelcomeView()
}
