//
//  SessionCardView.swift
//  DiceRoll
//
//  Created by Łukasz Szeląg on 09/03/2026.
//

import SwiftUI

struct SessionCardView: View {
    
    let session: Session
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil),
    ]
    
    var body: some View {
        CardView(title: session.name) {
            VStack {
                Text("Created: \(session.dateCreated.formatted())")
                    .textStyle(color: .themeRed, font: .caption)
                Text("Last activity: \(session.lastUpdated.formatted())")
                    .textStyle(color: .themeRed, font: .caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Divider()
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(session.players.indices, id: \.self) { index in
                        HStack {
                            Circle()
                                .fill(Color.decode(session.players[index].color))
                                .frame(width: 6)
                            Text(session.players[index].name)
                                .textStyle(color: .black, font: .caption)
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                        }
                    }
                }
            }
        }
        .shadow(radius: 5)
    }
}

#Preview {
    SessionCardView(session: .example())
}
