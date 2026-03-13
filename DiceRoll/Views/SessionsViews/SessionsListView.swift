//
//  SessionsListView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 10/03/2026.
//

import SwiftUI

struct SessionsListView: View {
    
    var viewModel: SessionsView.ViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.filteredSessions, id: \.self) { session in
                    NavigationLink(destination: ActiveSessionView(session: session)) {
                        SessionCardView(session: session)
                            .overlay(alignment: .bottomTrailing) {
                                Button {
                                    viewModel.markSessionToBeDeleted(session)
                                    viewModel.displayDeleteAlert(for: session)
                                } label: {
                                    Image(systemName: "trash")
                                        .textStyle(color: .red, font: .headline)
                                        .padding()
                                }
                                .buttonStyle(.plain)
                            }
                            .visualEffect { content, proxy in
                                content
                                    .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 12, axis: (x:0 , y: 0, z: 1))
                            }
                    }
                }
            }
            .padding(.vertical, 30)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .animation(.bouncy(duration: 0.3), value: viewModel.filteredSessions)
    }
}

#Preview {
    SessionsListView(viewModel: .init())
}
