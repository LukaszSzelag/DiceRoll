//
//  Model.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 22/12/2025.
//

import Foundation
import SwiftData

@Model
class Session: Identifiable {
    var id: UUID
    var name: String
    var dateCreated: Date
    var lastUpdated: Date
    
    @Relationship(deleteRule: .cascade)
    var players: [Player] = []

    @Relationship(deleteRule: .cascade)
    var rollHistory: [RollRecord] = []
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.dateCreated = .now
        self.lastUpdated = .now
    }
}

extension Session {
    static func example() -> Session {
        let exampleSession = Session(name: "Munchkin")
        let playerOne = Player(name: "John", color: .red)
        let playerTwo = Player(name: "Pamela", color: .blue)
        let playerThree = Player(name: "Tanya", color: .yellow)
        let playerFour = Player(name: "Lucas", color: .teal)
        let playerFive = Player(name: "Mathew", color: .orange)
        let playerSix = Player(name: "Agatha", color: .brown)
        let playerSeven = Player(name: "Paul", color: .pink)
        
        
        exampleSession.players.append(playerOne)
        exampleSession.players.append(playerTwo)
        exampleSession.players.append(playerThree)
        exampleSession.players.append(playerFour)
        exampleSession.players.append(playerFive)
        exampleSession.players.append(playerSix)
        exampleSession.players.append(playerSeven)
        
        let rollRecord1 = RollRecord(result: 1, player: playerOne)
        let rollRecord2 = RollRecord(result: 4, player: playerTwo)
        let rollRecord3 = RollRecord(result: 2, player: playerThree)
        let rollRecord4 = RollRecord(result: 6, player: playerFour)
        let rollRecord5 = RollRecord(result: 3, player: playerSix)
        let rollRecord6 = RollRecord(result: 3, player: playerOne)
        
        exampleSession.rollHistory.append(rollRecord1)
        exampleSession.rollHistory.append(rollRecord2)
        exampleSession.rollHistory.append(rollRecord3)
        exampleSession.rollHistory.append(rollRecord4)
        exampleSession.rollHistory.append(rollRecord5)
        exampleSession.rollHistory.append(rollRecord6)
        
        return exampleSession
    }
}
