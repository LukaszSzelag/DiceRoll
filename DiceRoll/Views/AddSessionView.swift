//
//  AddSessionView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 29/12/2025.
//

import SwiftUI
import SwiftData

struct AddSessionView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        @Bindable var viewModel = viewModel
        GradientBackground() {
            VStack(spacing: 12) {
                Text("Add new session")
                    .textStyle(font: .largeTitle)
                
                Spacer()
                
                CardView(size: .big) {
                    switch viewModel.cardViewState {
                    case .addingSessionInfo:
                        AddSessionInformationView(viewModel: viewModel)
                            .transition(.scale)
                    case .addingPlayer:
                        AddPlayerView(viewModel: viewModel)
                            .transition(.scale)
                    }
                }
                Spacer()
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle")
                    }
                    .textStyle(color: .black, font: .title)
                    .softShadowBackground(cornerRadius: .infinity)
                    
                    Button("Create Session") {
                        viewModel.createSession(using: modelContext)
                        dismiss()
                    }
                    .textStyle(color: .black, font: .title)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 8)
                    .softShadowBackground(cornerRadius: .infinity)
                    .opacity(viewModel.dataValid ? 1 : 0.6)
                    .disabled(!viewModel.dataValid)
                }
                .padding()
            }
            .animation(.snappy(duration: 0.3), value: viewModel.cardViewState)
            .shadow(radius: 3, y: 2)
        }
    }
    
    
    
}

#Preview {
    AddSessionView()
        .modelContainer(for: [Session.self, Player.self, RollRecord.self])
}
