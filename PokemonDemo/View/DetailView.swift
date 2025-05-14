//
//  DetailView.swift
//  PokemonDemo
//
//  Created by MacBook on 13/05/2025.
//

import SwiftUI
import Alamofire

struct DetailView: View {
    @StateObject private var detailViewModel = PokemonDetailViewModel()
    let url: String
    
    var body: some View {
        ScrollView {
            if let detail = detailViewModel.detail {
                VStack(spacing: 20) {
                    // Name
                    Text(detail.name.capitalized)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.top)
                    
                    // Pokémon Image Card
                    AsyncImage(url: URL(string: (detail.sprites.other?.home?.frontDefault)!)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                            .padding(.horizontal)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                    }
                    
                    // Stats Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Stats")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 8)
                        
                        ForEach(detail.stats, id: \.stat.name) { stat in
                            VStack(alignment: .leading, spacing: 4) {
                                StatProgressView(statName: stat.stat.name, statValue: stat.base_stat, maxValue: 150)
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                }
                .padding(.vertical)
            } else {
                ProgressView()
                    .padding()
                    .onAppear {
                        detailViewModel.fetchDetails(from: url)
                    }
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .alert(isPresented: $detailViewModel.showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(detailViewModel.errorMessage ?? "Unknown error"),
                dismissButton: .default(Text("Retry")) {
                    detailViewModel.fetchDetails(from: url)
                }
            )
        }
    }
}
