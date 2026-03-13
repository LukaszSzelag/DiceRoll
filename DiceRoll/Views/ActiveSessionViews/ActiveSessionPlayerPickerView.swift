//
//  ActiveSessionPlayerPickerView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 13/03/2026.
//

import SwiftUI

struct ActiveSessionPlayerPickerView: View {
    
    var viewModel: ActiveSessionView.ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.activeSession.players) { player in
                Button {
                    viewModel.setActivePlayer(player)
                } label: {
                    HStack {
                        PokerChip(color: Color.decode(player.color), size: .small)
                        Text(player.name)
                            .textStyle(color: .white, font: .headline)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 24)
                    .background {
                        LinearGradient(colors: [viewModel.activePlayer?.id == player.id ? .themeGold.opacity(0.3) : .clear, .clear], startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(.infinity)
                    }
                }
                .opacity(viewModel.areButtonsActive ? 1 : 0.6)
                .disabled(!viewModel.areButtonsActive)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 16))
            }
        }
        .listStyle(.plain)
        .animation(.easeInOut, value: viewModel.activePlayer)
    }
}

#Preview {
    ZStack {
        GradientBackground()
        ActiveSessionPlayerPickerView(viewModel: .init(activeSession: .example()))
    }
}
