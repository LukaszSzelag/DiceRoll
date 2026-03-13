//
//  DiceComponents.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 24/12/2025.
//

import SwiftUI

struct DiceComponentsPreviews: PreviewProvider {
    static var previews: some View {
        GradientBackground() {
            DiceView(size: 100, color: .black)
        }
    }
}

struct DiceView: View {
    
    var sides: Int
    var size: CGFloat
    var color: Color
    
    init(sides: Int = 6, size: CGFloat = 100, color: Color = .white) {
        self.sides = sides
        self.size = size
        self.color = color
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: size/3)
            .fill(color)
            .frame(width: size, height: size)
            .overlay {
                Text("\(sides)")
                    .foregroundStyle(color == .black ? .white : .black)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .minimumScaleFactor(0.3)
            }
            .background {
                color.brightness(color == .black ? 0.1 : -0.1)
                    .cornerRadius(size/10)
                    .shadow(radius: 3, y: 2)
            }
            .softShadowBackground(color: .clear, cornerRadius: size/10, padding:0)
    }
}
