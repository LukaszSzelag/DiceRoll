//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 22/12/2025.
//

import SwiftUI
import SwiftData

@main
struct DiceRollApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenuView()
        }
        .modelContainer(for: [Session.self, Player.self, RollRecord.self])
    }
}
