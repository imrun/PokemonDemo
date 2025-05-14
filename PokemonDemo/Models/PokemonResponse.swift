//
//  PokemonResponse.swift
//  PokemonDemo
//
//  Created by MacBook on 13/05/2025.
//

import Foundation

struct PokemonResponse: Codable {
    let results: [PokemonList]
}

struct PokemonList: Codable, Identifiable {
    var id: String { name }
    let name: String
    let url: String
}

struct PokemonDetail: Codable {
    struct Stat: Codable {
        let base_stat: Int
        let stat: StatDetail
    }

    struct StatDetail: Codable {
        let name: String
    }

    let name: String
    let stats: [Stat]
    let sprites: Sprite
}

struct Sprite: Codable {
    let front_default: String
}
