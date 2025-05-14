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
    
    var imageUrl: String {
        let id = url.split(separator: "/").last { !$0.isEmpty } ?? "1"
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
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
    let other: OtherSprites?
}

struct OtherSprites: Codable {
    let home: Home?
}

struct Home: Codable {
    let frontDefault: String?
    let frontFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}
