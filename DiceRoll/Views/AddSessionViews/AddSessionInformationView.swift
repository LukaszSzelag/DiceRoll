//
//  AddSessionInformationView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 06/03/2026.
//

import SwiftUI

struct AddSessionInformationView: View {
    
    var viewModel: AddSessionView.ViewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            TextField("Session name", text: $viewModel.sessionName, prompt: Text("Session name").foregroundColor(.black.opacity(0.5)))
                .textStyle(color: .black, font: .largeTitle)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .accentColor(.black)
            
            Label("At least 3 characters long", systemImage: "info.circle")
                .textStyle(color: viewModel.sessionNameValid ? .green : .gray, font: .caption)
            
            Divider()
            
            if viewModel.players.isEmpty {
                VStack {
                    Spacer()
                    Image(systemName: "person.2.slash")
                        .textStyle(color: .black, font: .largeTitle)
                    Text("No players yet")
                        .textStyle(color: .black, font: .headline)
                    Text("Add at least one player")
                        .textStyle(color: .black, font: .caption)
                    Spacer()
                }
            } else {
                List {
                    ForEach(viewModel.players, id: \.self) { player in
                        HStack {
                            PokerChip(color: Color.decode(player.color), size: .small)
                            Text(player.name)
                                .textStyle(color: .black, font: .default)
                            Spacer()
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.black)
                                .font(.caption)
                            Image(systemName: "trash")
                                .foregroundStyle(.black)
                                .font(.caption)
                        }
                        .listRowBackground(Color.white)
                    }
                    .onDelete(perform: viewModel.deletePlayer)
                }
                .listStyle(.plain)
            }
            
            Spacer()
            
            Button("Add player", systemImage: "plus.circle") {
                viewModel.addingPlayer()
            }
            .textStyle(color: .black, font: .headline)
            .softShadowBackground(cornerRadius: .infinity)
            .disabled(viewModel.playerCountExceeded)
        }
    }
}

#Preview {
    AddSessionInformationView(viewModel: .init())
}
