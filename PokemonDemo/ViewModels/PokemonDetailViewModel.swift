//
//  PokemonDetailViewModel.swift
//  PokemonDemo
//
//  Created by MacBook on 13/05/2025.
//

import Foundation
import Alamofire


class PokemonDetailViewModel: ObservableObject {
    @Published var detail: PokemonDetail?
    @Published var errorMessage: String?
    @Published var showErrorAlert = false
    
    func fetchDetails(from url: String) {
        errorMessage = nil
        AF.request(url)
            .validate()
            .responseDecodable(of: PokemonDetail.self) { [weak self] response in
                switch response.result {
                case .success(let result):
                    DispatchQueue.main.async {
                        self?.detail = result
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorMessage = "\(error.localizedDescription)"
                        self?.showErrorAlert = true
                    }
                }
            }
    }
}
