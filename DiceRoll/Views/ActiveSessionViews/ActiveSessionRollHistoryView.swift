//
//  ActiveSessionRollHistoryView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 13/03/2026.
//

import SwiftUI

struct ActiveSessionRollHistoryView: View {
    var viewModel: ActiveSessionView.ViewModel
    
    var body: some View {
        VStack {
            if viewModel.rollHistory.isEmpty {
                VStack {
                    Spacer()
                    ContentUnavailableView("No rolls yet", systemImage: "dice", description: Text("Roll the dice to see your roll history"))
                        .textStyle(color: .white)
                }
            } else {
                HStack {
                    HStack {
                        Button {
                            viewModel.filterRollHistory()
                        } label: {
                            Image(systemName: viewModel.filteringRollHistory ? "xmark.circle" : "person.circle")
                                .asButton(.headline)
                        }
                        .frame(width: 50, height: 50)
                    }
                    if !viewModel.filteringRollHistory {
                        Spacer()
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.activeSession.players) { player in
                                    Button {
                                        viewModel.setFilterRollHistoryPlayer(player)
                                    } label: {
                                        PokerChip(color: Color.decode(player.color), size: .small)
                                    }
                                    .padding(2)
                                    .background {
                                        Circle()
                                            .fill(.clear)
                                            .stroke(viewModel.filterRollHistoryPlayer == player ? .black : .clear, lineWidth: 1)
                                    }
                                    .padding([.vertical, .leading], 2)
                                }
                            }
                        }
                    }
                }
                List {
                    ForEach(viewModel.filteredRollHistory) { rollRecord in
                        HStack {
                            PokerChip(color: Color.decode(rollRecord.player.color), size: .small)
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(rollRecord.result)")
                                        .textStyle(font: .title)
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 6)
                                    Text("\(rollRecord.player.name)")
                                        .textStyle(color: .white, font: .headline)
                                }
                                Text("\(rollRecord.rollDate.formatted())")
                                    .textStyle(color: .white.opacity(0.8), font: .caption)
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.trailing, 24)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 16))
                    }
                }
                .listStyle(.plain)
            }
        }
        .animation(.snappy(duration: 0.3), value: viewModel.filteringRollHistory)
        .animation(.snappy(duration: 0.3), value: viewModel.filterRollHistoryPlayer)
    }
}

#Preview {
    ZStack {
        GradientBackground() {
            ActiveSessionRollHistoryView(viewModel: .init(activeSession: .example()))
        }
    }
}
