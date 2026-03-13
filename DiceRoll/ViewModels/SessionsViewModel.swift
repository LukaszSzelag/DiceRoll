//
//  SessionsViewModel.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 09/03/2026.
//

import Foundation
import SwiftData

extension SessionsView {

    enum SortKeys: String, CaseIterable, Identifiable {
        case name = "Name"
        case dateCreated = "Date Created"
        case lastActivity = "Last Activity"
        
        var id: String { rawValue }
    }
    
    @Observable
    class ViewModel {
        var sessions: [Session] = []
        
        // MARK: - Filter properties
        var sortKey: SortKeys = .lastActivity
        var filterText: String = ""
        
        var filteredSessions: [Session] {
            var sessionsToSort = sessions
            
            if !filterText.isEmpty {
                sessionsToSort = sessionsToSort.filter { $0.name.contains(filterText) }
            }
            
            switch sortKey {
            case .name:
                sessionsToSort.sort { $0.name < $1.name }
            case .dateCreated:
                sessionsToSort.sort { $0.dateCreated > $1.dateCreated }
            case .lastActivity:
                sessionsToSort.sort { $0.lastUpdated > $1.lastUpdated }
            }
            
            return sessionsToSort
        }
        
        var showDeleteAlert: Bool = false
        var showingFilterBar: Bool = false
        var alertMessage: String = ""
        var markedSession: Session? = nil
        
        // MARK: - Functions
        func fetchSessions(using modelContext: ModelContext) {
            let descriptor = FetchDescriptor<Session>()
            do {
                let sessions = try modelContext.fetch(descriptor)
                self.sessions = sessions
            } catch {
                print("Could not load sessions from modelContext: \(error.localizedDescription)")
            }
        }
        
        func displayDeleteAlert(for session: Session) {
            showDeleteAlert = true
            alertMessage = "Are you sure you want to delete \(session.name)?"
        }
        
        func markSessionToBeDeleted(_ session: Session) {
            markedSession = session
        }
        
        func deleteSession(using modelContext: ModelContext) {
            guard let session = markedSession else { return }
            
            defer {
                markedSession = nil
            }
            
            modelContext.delete(session)
            fetchSessions(using: modelContext)
            do {
                try modelContext.save()
            } catch {
                print("Failed to delete session: \(error.localizedDescription)")
            }
        }
        
        func showFilterBar() {
            showingFilterBar.toggle()
        }
    }
}
