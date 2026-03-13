//
//  AddSessionViewModel.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 06/03/2026.
//

import Foundation
import SwiftData
import SwiftUI

enum AddSessionCardViewState {
    case addingSessionInfo
    case addingPlayer
}

extension AddSessionView {
    @Observable
    class ViewModel {
        // MARK: - Binded properties
        var sessionName: String = ""
        var newPlayerName: String = ""
        
        // MARK: - View state properties
        var cardViewState: AddSessionCardViewState = .addingSessionInfo
        var isChoosingPlayerColor: Bool = false
        
        var players: [Player] = []
        var playerColors: [PlayerColor] = [] {
            didSet {
                guard let firstColor = playerColors.first else { return }
                newPlayerColor = firstColor
            }
        }
        var playerCountExceeded: Bool {
            playerColors.count == 0
        }
        var newPlayerColor: PlayerColor = .blue
        
        // MARK: - Validation properties
        var newPlayerNameValid: Bool {
            newPlayerName.trimmingCharacters(in: .whitespacesAndNewlines).count > 2
        }
        
        var sessionNameValid: Bool {
            sessionName.trimmingCharacters(in: .whitespacesAndNewlines).count > 2
        }
        
        var dataValid: Bool {
            sessionNameValid && !players.isEmpty
        }
        
        // MARK: - INIT
        init() {
            loadPlayerColors()
        }
        
        func loadPlayerColors() {
            playerColors = PlayerColor.allCases
            sortPlayerColors()
        }
        
        // MARK: - Players handling functions
        func addPlayer() {
            let player = Player(name: newPlayerName, color: newPlayerColor)
            players.append(player)
            removePlayerColor()
            newPlayerName = ""
        }
        
        func deletePlayer(indexSet: IndexSet) {
            guard let indexOfDeletedPlayer = indexSet.first else { return }
            let deletedPlayerColor = players[indexOfDeletedPlayer].color
            playerColors.append(deletedPlayerColor)
            sortPlayerColors()
            players.remove(at: indexOfDeletedPlayer)
        }
        
        func removePlayerColor() {
            playerColors.removeAll(where: { $0.rawValue == newPlayerColor.rawValue })
        }
        
        func setNewPlayerColor(_ color: PlayerColor) {
            newPlayerColor = color
        }
        
        func sortPlayerColors() {
            playerColors.sort { $0.rawValue < $1.rawValue }
        }
        
        // MARK: - View state driving functions
        func choosingColor() {
            isChoosingPlayerColor = true
        }
        
        func notChoosingColor() {
            isChoosingPlayerColor = false
        }
        
        func addingPlayer() {
            cardViewState = .addingPlayer
        }
        
        func addingSessionInfo() {
            cardViewState = .addingSessionInfo
        }
        
        // MARK: - Create Session
        func createSession(using modelContext: ModelContext) {
            guard dataValid else { return }
            
            let newSession = Session(name: sessionName)
            newSession.players = players
            
            modelContext.insert(newSession)
            do {
                try modelContext.save()
            } catch {
                print("Couldn't save session: \(error.localizedDescription)")
            }
        }
    }
}
