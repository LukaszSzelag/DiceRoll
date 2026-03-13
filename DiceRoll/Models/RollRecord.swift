//
//  ThrowRecord.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 06/03/2026.
//

import Foundation
import SwiftData

@Model
class RollRecord: Identifiable, Hashable {
    var id: UUID
    var result: Int
    var rollDate: Date
    var player: Player
    
    init(result: Int, throwDate: Date = .now, player: Player) {
        self.id = UUID()
        self.result = result
        self.rollDate = throwDate
        self.player = player
    }
}
