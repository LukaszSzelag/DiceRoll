//
//  SessionsFilterBarView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 10/03/2026.
//

import SwiftUI

struct SessionsFilterBarView: View {
    
    var viewModel: SessionsView.ViewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(spacing: 24) {
            if viewModel.showingFilterBar {
               HStack {
                   VStack(alignment: .leading, spacing: 12) {
                        Text("Sort by:")
                            .textStyle(color: .white, font: .headline)
                        
                       ForEach(SessionsView.SortKeys.allCases) { sortKey in
                           Button {
                               viewModel.sortKey = sortKey
                           } label: {
                               HStack {
                                   Image(systemName: viewModel.sortKey == sortKey ? "checkmark.circle" : "circle")
                                       .textStyle(color: .black, font: .headline)
                                       .softShadowBackground(cornerRadius: .infinity, padding: 0)
                                   Text(sortKey.rawValue)
                                       .textStyle(color: .white, font: .headline)
                               }
                           }
                       }
                    }
                    Spacer()
                }
                .transition(.move(edge: .leading))
                .frame(maxWidth: .infinity)
            } else {
                HStack {
                    Image(systemName: "arrow.left.arrow.right")
                        .textStyle(color: .white, font: .headline)
                    Text("\(viewModel.sortKey.rawValue)")
                        .textStyle(font: .headline)
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
            
            
            HStack {
                Button {
                    viewModel.showFilterBar()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .textStyle(color: .black, font: .title)
                        .softShadowBackground(cornerRadius: .infinity, padding: 8)
                }
                
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .textStyle(color: .white, font: .title)
                    TextField("Search", text: $viewModel.filterText, prompt: Text("Search").foregroundStyle(.white.opacity(0.3)))
                        .textStyle(color: .white, font: .title2)
                }
                .softShadowBackground(color: .clear, cornerRadius: .infinity, padding: 8)
                .transition(.scale)
                
                NavigationLink(destination: AddSessionView()) {
                    Image(systemName: "plus.circle")
                        .textStyle(color: .black, font: .title)
                        .softShadowBackground(cornerRadius: .infinity, padding: 8)
                }
            }
        }
        .frame(width: .infinity)
        .animation(.snappy(duration: 0.3), value: viewModel.showingFilterBar)
    }
}

#Preview {
    ZStack {
        GradientBackground()
        SessionsFilterBarView(viewModel: .init())
    }
}
