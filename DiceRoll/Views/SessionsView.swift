//
//  SessionsView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 27/12/2025.
//

import SwiftUI
import SwiftData

struct SessionsView: View {
    
    @Query(sort: \Session.lastUpdated, order: .reverse) var sessions: [Session]
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: ViewModel = ViewModel()
    
    
    var body: some View {
        GradientBackground() {
        
            VStack(spacing: 12) {
                Text("Pick the session")
                    .textStyle(font: .largeTitle)
                
                Spacer()
                
                if viewModel.sessions.isEmpty {
                    ContentUnavailableView("No Sessions yet", systemImage: "pencil.and.outline", description: Text("Add a new session to begin"))
                        .textStyle(color: .white, font: .title)
                } else if viewModel.filteredSessions.isEmpty{
                    ContentUnavailableView("No search results found", systemImage: "magnifyingglass", description: Text("Try different name"))
                        .textStyle(color: .white, font: .title)
                } else {
                    SessionsListView(viewModel: viewModel)
                }
                Spacer()
                Spacer()
            }
            .overlay(alignment: .bottom) {
                if viewModel.sessions.isEmpty {
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddSessionView()) {
                            Image(systemName: "plus.circle")
                                .textStyle(color: .black, font: .title)
                                .softShadowBackground(cornerRadius: .infinity, padding: 8)
                        }
                    }
                    .padding()
                } else {
                    SessionsFilterBarView(viewModel: viewModel)
                        .padding()
                }
            }
            .shadow(radius: 3, y: 2)
            .alert(isPresented: $viewModel.showDeleteAlert) {
                Alert(title: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    viewModel.deleteSession(using: modelContext)
                }, secondaryButton: .cancel())
            }
        }
        .onAppear {
            viewModel.fetchSessions(using: modelContext)
        }
    }
    
}

#Preview {
    SessionsView()
        .modelContainer(for: [Session.self, Player.self, RollRecord.self])
}


