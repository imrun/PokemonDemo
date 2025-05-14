//
//  StatProgressView.swift
//  PokemonDemo
//
//  Created by MacBook on 14/05/2025.
//

import Foundation
import SwiftUI

struct StatProgressView: View {
    let statName: String
    let statValue: Int
    let maxValue: Float
    
    @State private var animatedValue: Float = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(statName.capitalized)
                    .fontWeight(.medium)
                Spacer()
                Text("\(statValue)")
                    .font(.caption)
                    .foregroundColor(colorForStat(statName))
            }
            
            ProgressView(value: animatedValue, total: maxValue)
                .accentColor(colorForStat(statName))
                .animation(.easeOut(duration: 0.8), value: animatedValue)
        }
        .onAppear {
            withAnimation {
                animatedValue = Float(statValue)
            }
        }
    }
    
    func colorForStat(_ statName: String) -> Color {
        switch statName.lowercased() {
        case "hp": return .green
        case "attack": return .red
        case "defense": return .blue
        case "special-attack": return .orange
        case "special-defense": return .purple
        case "speed": return .blue
        default: return .gray
        }
    }
}
