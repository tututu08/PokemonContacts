//
//  PokemonAPI.swift
//  PokemonContacts
//
//  Created by 강성훈 on 4/23/25.
//

import Foundation

struct PokemonModel : Codable {
    let name : String
    let sprites : Sprites
    let id : Int
}

struct Sprites : Codable {
    let frontDefault : String
     
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
