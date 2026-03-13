//
//  ActiveSessionViewModel.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 12/03/2026.
//

import Foundation
import SwiftData

extension ActiveSessionView {
    
    enum RollingPhase: CaseIterable {
        case start
        case throwing
        case rolling
        case showingResult
    }
    
    enum PlayerSwitchPhase: CaseIterable {
        case start
        case switching
    }
    
    enum ListContentState {
        case playersPicker
        case throwHistory
    }
    
    @Observable
    class ViewModel {
        // MARK: - Initial properties
        var activeSession: Session
        
        // MARK: - Player properties
        var activePlayer: Player? = nil
        
        // MARK: - Dice properties
        var diceSides: Int = 6
        var result: Int = 6
        
        // MARK: - View states
        var listState: ListContentState = .playersPicker
        
        // MARK: - Roll history properties
        var rollHistory: [RollRecord] {
            activeSession.rollHistory.sorted { $0.rollDate > $1.rollDate }
        }
        var filteredRollHistory: [RollRecord] {
            if let player = filterRollHistoryPlayer {
                return rollHistory.filter { $0.player.id == player.id }
            } else {
                return rollHistory
            }
        }
        var filteringRollHistory: Bool = false
        var filterRollHistoryPlayer: Player? = nil
        
        // MARK: - Animating properties
        var animatingPlayerSwitch: Bool = false
        var animatingRoll: Bool = false
        
        var areButtonsActive: Bool = true
        
        // MARK: - INIT
        init(activeSession: Session) {
            self.activeSession = activeSession
            
            if let firstPlayer = activeSession.players.first {
                setActivePlayer(firstPlayer)
            }
        }
        
        // MARK: - Functions
        func setActivePlayer(_ player: Player) {
            activePlayer = player
            animatePlayerSwitch()
        }
        
        func setDiceSides(_ sides: Int) {
            diceSides = sides
        }
        
        func rollDice() {
            areButtonsActive = false
            animatingRoll.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
                guard let self else { return }
                self.result = Int.random(in: 1...self.diceSides)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self else { return }
                self.areButtonsActive = true
                self.addRollRecord()
            }
            updateLastActivityDate()
        }
        
        func showPlayers() {
            listState = .playersPicker
        }
        
        func showRollHistory() {
            listState = .throwHistory
        }
        
        func checkPlayerIndex(_ player: Player) -> CGFloat {
            if let index = activeSession.players.firstIndex(of: player) {
                return CGFloat(index)
            }
            
            return 0
        }
        
        func animatePlayerSwitch() {
            animatingPlayerSwitch.toggle()
        }
    
        func filterRollHistory() {
            if filteringRollHistory {
                filteringRollHistory = false
                filterRollHistoryPlayer = nil
            } else {
                filteringRollHistory = true
            }
        }
        
        func setFilterRollHistoryPlayer(_ player: Player) {
            filterRollHistoryPlayer = player
        }
        
        func addRollRecord() {
            guard let player = activePlayer else { return }
            let record = RollRecord(result: result, player: player)
            activeSession.rollHistory.append(record)
        }
        
        func updateLastActivityDate() {
            activeSession.lastUpdated = .now
        }
    }
}

