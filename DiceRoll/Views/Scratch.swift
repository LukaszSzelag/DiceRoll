//
//  Scratch.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 06/03/2026.
//

import SwiftUI

struct Scratch: View {
    var body: some View {
        GradientBackground()
    }
}

#Preview {
    ZStack {
        Color.themeRed.ignoresSafeArea()
        Scratch()
    }
}
