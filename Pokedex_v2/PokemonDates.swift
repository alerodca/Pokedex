//
//  DatosPokemon.swift
//  Pokedex_v2
//
//  Created by Alejandro Rodríguez Cañete on 14/9/23.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int?
    let attack: Int?
    let defense: Int?
    let description: String?
    let name: String?
    let imageUrl: String?
    let type: String?
}
