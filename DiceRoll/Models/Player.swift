//
//  Player.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 06/03/2026.
//

import Foundation
import SwiftData

enum PlayerColor: String, CaseIterable, Codable, Identifiable {
    case blue = "blue"
    case red = "red"
    case green = "green"
    case yellow = "yellow"
    case purple = "purple"
    case pink = "pink"
    case brown = "brown"
    case teal = "teal"
    case orange = "orange"
    case mint = "mint"
    case black = "black"
    case white = "white"
    
    var id: String { rawValue }
}

@Model
class Player: Identifiable, Hashable {
    var id: UUID
    var name: String
    var color: PlayerColor
    
    init(name: String, color: PlayerColor) {
        self.id = UUID()
        self.name = name
        self.color = color
    }
}
