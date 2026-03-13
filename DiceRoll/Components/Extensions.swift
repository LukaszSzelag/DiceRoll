//
//  Extensions.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 27/12/2025.
//

import SwiftUI

struct Extensions: View {
    var body: some View {
        ZStack {
//            AngularGradient(colors: [.themeGold, .themeGold, .white, .themeGold, .themeGold, Color.themeGold.brightness(0.8), .themeGold, .themeGold, .white], center: .center, angle: .degrees(45)).ignoresSafeArea()
//            
//            
//            Text("Hello, World!")
//                .padding()
//                .background(.themeGold)
//                .cornerRadius(12)
        }
    }
}

#Preview {
    Extensions()
}

extension View {
    func textStyle<S: ShapeStyle>(color: S = LinearGradient(colors: [.themeGold, .themeDarkGold], startPoint: .top, endPoint: .bottom), font: Font = .headline) -> some View {
        return self
            .foregroundStyle(color)
            .font(font)
            .bold()
    }
    
    func asButton() -> some View {
        return self
            .padding(8)
            .background(.themeGold.gradient)
            .cornerRadius(20)
            .offset(y: -4)
            .background(.themeDarkGold)
            .cornerRadius(20)
    }
    
    func softShadowBackground<S: ShapeStyle>(color: S = LinearGradient(colors: [.themeGold, .themeDarkGold], startPoint: .top, endPoint: .bottom), cornerRadius: CGFloat = 12, padding: CGFloat = 8) -> some View {
        self
            .padding(padding)
            .background(color)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .offset(y: 0.3)
                    .stroke(.shadowStroke, lineWidth: 1.3)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(radius: 2, x: 0, y: 2)
    }
    
    func noShadowBackground<S: ShapeStyle>(color: S, cornerRadius: CGFloat = 8, padding: CGFloat = 8) -> some View {
        self
            .padding(padding)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        let format = "dd.MM.yyyy HH:mm"
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Color {
    static func decode(_ playerColor: PlayerColor) -> Color {
        switch playerColor {
        case .blue: return Color.blue
        case .red: return Color.red
        case .green: return Color.green
        case .yellow: return Color.yellow
        case .purple: return Color.purple
        case .pink: return Color.pink
        case .brown: return Color.brown
        case .teal: return Color.teal
        case .orange: return Color.orange
        case .mint: return Color.mint
        case .black: return Color.black
        case .white: return Color.white
        }
    }
    
    static func encode(_ color: Color) -> PlayerColor {
        switch color {
        case .blue: return .blue
        case .red: return .red
        case .green: return .green
        case .yellow: return .yellow
        case .purple: return .purple
        case .pink: return .pink
        case .brown: return .brown
        case .teal: return .teal
        case .orange: return .orange
        case .mint: return .mint
        case .black: return .black
        case .white: return .white
        default: return .blue
        }
    }
}
