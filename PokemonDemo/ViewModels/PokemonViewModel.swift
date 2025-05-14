//
//  PokemonViewModel.swift
//  PokemonDemo
//
//  Created by MacBook on 13/05/2025.
//

import Foundation
import Combine
import Alamofire

class PokemonViewModel: ObservableObject {
    @Published var allPokemon: [PokemonList] = []
    @Published var searchText = ""
    @Published var errorMessage: String?
    @Published var showErrorAlert = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var filteredPokemon: [PokemonList] {
        let result: [PokemonList]
        if searchText.isEmpty {
            result = allPokemon
        } else {
            result = allPokemon.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        
        return result
    }
    
    init() {
        fetchPokemonList()
    }
    
    // Using Alamofire
    func fetchPokemonList() {
        AF.request(Constants().url)
            .validate()
            .responseDecodable(of: PokemonResponse.self) { response in
                switch response.result {
                case .success(let result):
                    DispatchQueue.main.async {
                        self.allPokemon = result.results
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "\(error.localizedDescription)"
                        self.showErrorAlert = true
                    }
                }
            }
    }
}
