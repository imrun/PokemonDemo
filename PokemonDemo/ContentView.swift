//
//  ContentView.swift
//  PokemonDemo
//
//  Created by MacBook on 13/05/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.filteredPokemon) { pokemon in
                    NavigationLink(destination: DetailView(url: pokemon.url)) {
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                            
                            Text(pokemon.name.capitalized)
                                .font(.headline)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .navigationTitle("Pokemon")
                .searchable(text: $viewModel.searchText)
                .alert(isPresented: $viewModel.showErrorAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("Retry"), action: {
                        viewModel.fetchPokemonList()
                    }))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
