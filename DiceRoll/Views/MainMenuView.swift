//
//  MainMenuView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 24/12/2025.
//

import SwiftUI
import SwiftData

struct MainMenuView: View {
    
    @State var goToSessions: Bool = false
    
    var body: some View {
        NavigationStack {
            GradientBackground() {
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Logo()
                        Text("Rolling Dices")
                            .textStyle(font: .title)
                    }
                    Text("Tap anywhere to continue")
                        .textStyle(color: .white, font: .caption)
                }
                .padding()
                .shadow(radius: 3, y: 2)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                goToSessions = true
            }
            .navigationDestination(isPresented: $goToSessions) {
                SessionsView()
            }
        }
    }
}

#Preview {
    MainMenuView()
        .modelContainer(for: [Session.self, Player.self, RollRecord.self])
}
