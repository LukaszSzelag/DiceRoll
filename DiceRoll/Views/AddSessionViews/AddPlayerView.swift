//
//  AddPlayerView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 06/03/2026.
//

import SwiftUI

struct AddPlayerView: View {

    var viewModel: AddSessionView.ViewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(spacing: 24) {
            Spacer()
            if !viewModel.isChoosingPlayerColor {
                VStack {
                    Button {
                        viewModel.choosingColor()
                    } label: {
                        PokerChip(color: Color.decode(viewModel.newPlayerColor), size: .medium)
                    }
                }
                .padding(.vertical, 4)
                .transition(.scale)
            } else {
                VStack {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.playerColors, id: \.self) { color in
                                    Button {
                                        viewModel.setNewPlayerColor(color)
                                        viewModel.notChoosingColor()
                                    } label: {
                                        PokerChip(color: Color.decode(color), size: .medium)
                                    }
                                    .id(color)
                                }
                                .padding(.vertical, 4)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .onAppear {
                            proxy.scrollTo(viewModel.newPlayerColor, anchor: .center)
                        }
                    }
                }
                .transition(.scale)
            }
            
            VStack {
                TextField("Player name", text: $viewModel.newPlayerName, prompt: Text("Player name").foregroundColor(.black.opacity(0.5)))
                    .textStyle(color: .black, font: .largeTitle)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .accentColor(.black)
                
                Label("At least 3 characters long", systemImage: "info.circle")
                    .textStyle(color: viewModel.newPlayerNameValid ? .green : .gray, font: .caption)
            }
            
            Spacer()
            
            HStack {
                Button {
                    viewModel.notChoosingColor()
                    viewModel.addingSessionInfo()
                } label: {
                    Image(systemName: "arrow.backward.circle")
                        .frame(maxWidth: .infinity)
                        .asButton(.headline)
                }
                Button {
                    viewModel.addingSessionInfo()
                    viewModel.notChoosingColor()
                    viewModel.addPlayer()
                } label: {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .asButton(.headline)
                }
                .opacity(viewModel.newPlayerNameValid ? 1 : 0.6)
                .disabled(!viewModel.newPlayerNameValid)
            }
            .frame(maxWidth: .infinity)
        }
        .animation(.snappy(duration: 0.3), value: viewModel.isChoosingPlayerColor)
    }
}

#Preview {
    AddPlayerView(viewModel: .init())
}
