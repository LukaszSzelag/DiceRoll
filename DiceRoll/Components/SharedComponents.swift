//
//  SharedComponents.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 27/12/2025.
//

import SwiftUI

struct SharedComponentsPreviews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Hello", color: .blue, size: .standard, orientation: .horizontal) {
            Text("Hello")
        }
        .previewDisplayName("CardView")
        
        Logo()
            .previewDisplayName("Logo")
        
        
        GradientBackground() {
            PokerChip(color: .orange, size: .medium, text: "Paolo Marolo")
        }
        .previewDisplayName("PokerChip")
        
        DateCreatedBadge()
            .previewDisplayName("DateCreatedBadge")
    }
}

struct CardView<Content: View>: View {
    
    enum CardSize {
        case small
        case standard
        case big
    }
    
    enum CardOrientation {
        case vertical
        case horizontal
    }
    
    var title: String? = nil
    var color: Color = .themeGold
    var size: CardSize = .standard
    var orientation: CardOrientation = .vertical
    
    var width: CGFloat {
        switch size {
        case .small: return 100
        case .standard: return 200
        case .big: return 280
        }
    }
    var height: CGFloat {
        return width * 1.427
    }
    
    let content: Content
    
    init(title: String? = nil, color: Color = .themeDarkGold, size: CardSize = .standard, orientation: CardOrientation = .vertical, @ViewBuilder content: () -> Content) {
        self.title = title
        self.color = color
        self.size = size
        self.orientation = orientation
        self.content = content()
    }
    
    var body: some View {
        VStack {
            if let title = title {
                Text(title).textStyle(color: .black, font: .title)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                Divider()
                content
                Spacer()
            } else {
                content
            }
        }
        .padding()
        .frame(width: orientation == .vertical ? width : height, height: orientation == .vertical ? height : width)
        .background(.white)
        .cornerRadius(20)
        .padding(4)
        .background(color)
        .cornerRadius(20)
    }
}

struct Logo: View {
    var body: some View {
        Image(systemName: "diamond")
            .foregroundStyle(.black)
            .font(.title2)
            .background(
                Image(systemName: "hexagon.fill")
                    .font(.largeTitle)
                    .foregroundStyle(LinearGradient(colors: [.themeGold, .themeDarkGold], startPoint: .top, endPoint: .bottom))
                    .padding(8)
                    .shadow(radius: 3, y: 2)
            )
    }
}

struct PokerChip: View {
    
    enum ChipSize: CGFloat {
        case small = 30
        case medium = 60
        case large = 70
    }
    
    let color: Color
    let size: ChipSize
    let text: String?
    
    var font: Font {
        switch size {
        case .small:
            return .caption2
        case .medium:
            return .title3
        case .large:
            return .title
        }
    }
    var margin: CGFloat {
        size.rawValue/3.75
    }
    var dashLineInner: CGFloat {
        size.rawValue/10
    }
    var dashLineOuter: CGFloat {
        3.14*size.rawValue/12
    }
    
    init(color: Color, size: ChipSize = .medium, text: String? = nil) {
        self.color = color
        self.size = size
        self.text = text
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: size.rawValue+margin)
                
                Circle()
                    .stroke(color == .white ? .black : .white, style: StrokeStyle(lineWidth: 2, dash: [dashLineInner]))
                    .frame(width: size.rawValue-margin)
                
                Circle()
                    .stroke(color == .white ? .black : .white, style: StrokeStyle(lineWidth: size.rawValue/6, dash: [dashLineOuter]))
                    .frame(width: size.rawValue)
            }
            .softShadowBackground(color: .white, cornerRadius: .infinity, padding: 2)
            
            if let text = text {
                Text(text)
                    .textStyle(color: .black, font: font)
                    .noShadowBackground(color: .white, cornerRadius: .infinity, padding: 2)
                    .noShadowBackground(color: color, cornerRadius: .infinity, padding: 2)
            }
        }
    }
}

struct GradientBackground<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.themePeach, .themeRed], startPoint: .topLeading, endPoint: .bottom).ignoresSafeArea()
            
            VStack(spacing: 12) {
                content
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DateCreatedBadge: View {
    
    var body: some View {
        Image(systemName: "clock")
            .textStyle(color: .black, font: .title)
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "arrow.trianglehead.clockwise")
                    .textStyle(color: .black, font: .caption)
                    .softShadowBackground(color: .white, cornerRadius: .infinity, padding: 2)
            }
            .softShadowBackground(cornerRadius: .infinity)
    }
}

