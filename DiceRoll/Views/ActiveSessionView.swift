//
//  SessionView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 27/12/2025.
//

import SwiftUI
import SwiftData
import Combine

struct ActiveSessionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var session: Session
    @State var viewModel: ViewModel
    
    init(session: Session) {
        self.session = session
        _viewModel = State(initialValue: ViewModel(activeSession: session))
    }
    
    var body: some View {
        GradientBackground() {
            VStack(spacing: 12) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left.circle")
                            .textStyle(color: .black, font: .title)
                            .softShadowBackground(cornerRadius: .infinity)
                    }
                    Spacer()
                    Text(viewModel.activeSession.name)
                        .textStyle(font: .largeTitle)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .shadow(radius: 3, y: 2)
                }
                .padding(.horizontal)
                
                // MARK: - Info container
                HStack {
                    VStack(spacing: 12) {
                        DiceView(sides: viewModel.result)
                            .phaseAnimator(ActiveSessionView.RollingPhase.allCases, trigger: viewModel.animatingRoll) { content, phase in
                                content
                                    .scaleEffect(phase == .throwing ? 1.2 : 1)
                                    .scaleEffect(phase == .rolling ? 1.2 : 1)
                                    .rotationEffect(phase == .rolling ? .degrees(-360) : .zero)
                                    .offset(x: phase == .rolling ? -300 : 0)
                            } animation: { phase in
                                switch phase {
                                case .start:
                                    .none
                                case .throwing:
                                    .snappy(duration: 0.3)
                                case .rolling:
                                    .snappy(duration: 0.3)
                                case .showingResult:
                                    .snappy(duration: 1)
                                }
                            }
                        
                        Button {
                            viewModel.rollDice()
                        } label: {
                            Label("Roll", systemImage: "dice")
                                .frame(width: 80)
                                .asButton(.headline)
                        }
                        .opacity(viewModel.areButtonsActive ? 1 : 0.6)
                        .disabled(!viewModel.areButtonsActive)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 12) {
                        PokerChip(color: Color.decode(viewModel.activePlayer?.color ?? .white), size: .large)
                            .phaseAnimator(ActiveSessionView.PlayerSwitchPhase.allCases, trigger: viewModel.animatingPlayerSwitch) { content, phase in
                                content
                                    .offset(x: phase == .switching ? 300 : 0)
                            } animation: { phase in
                                switch phase {
                                case .start:
                                    .snappy(duration: 0.3)
                                case .switching:
                                    .snappy(duration: 0.3)
                                }
                            }
                        HStack {
                            Text(viewModel.activePlayer?.name ?? "Unknown")
                                .textStyle(color: .white, font: .title)
                            Text("rolls")
                                .textStyle(color: .white, font: .title)
                        }
                    }
                }
                .padding(.horizontal)
                
                // MARK: - List view picker
                HStack {
                    switch viewModel.listState {
                    case .playersPicker:
                        VStack {
                            Text("Choose player")
                                .textStyle(font: .title)
                                .lineLimit(1)
                        }
                        .transition(.move(edge: .top))
                    case .throwHistory:
                        VStack {
                            Text("Roll history")
                                .textStyle(font: .title)
                                .lineLimit(1)
                        }
                        .transition(.move(edge: .bottom))
                    }
                    
                    Spacer()
                    HStack {
                        Button {
                            viewModel.showPlayers()
                        } label: {
                            HStack {
                                Image(systemName: "person.3")
                                    .asButton(.headline)
                            }
                        }
                        Button {
                            viewModel.showRollHistory()
                        } label: {
                            HStack {
                                Image(systemName: "clock")
                                    .asButton(.headline)
                            }
                        }
                    }
                }
                .softShadowBackground(color: .clear, cornerRadius: .infinity)
                .padding(.horizontal)
                
                // MARK: - Players / roll history list
                switch viewModel.listState {
                case .playersPicker:
                    ActiveSessionPlayerPickerView(viewModel: viewModel)
                        .padding(.leading)
                    
                case .throwHistory:
                    ActiveSessionRollHistoryView(viewModel: viewModel)
                        .padding(.leading)
                }
            }
            .animation(.easeInOut, value: viewModel.listState)
            .animation(.snappy(duration: 0.3), value: viewModel.rollHistory)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ActiveSessionView(session: .example())
        .modelContainer(for: [Session.self, Player.self, RollRecord.self])
}
