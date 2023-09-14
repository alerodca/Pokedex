//
//  PokemonManager.swift
//  Pokedex_v2
//
//  Created by Alejandro Rodríguez Cañete on 14/9/23.
//

import Foundation

protocol pokemonManagerDelegate {
    func showPokemonList(list: [Pokemon])
}

struct PokemonManager {
    var delegate: pokemonManagerDelegate?
    
    func showPokemon() {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("Error al obtener datos, ERROR: \(error?.localizedDescription)")
                }
                
                if let secureData = data?.parseData(quitarString: "null,") {
                    if let pokemonList = self.JSONParse(pokemonDates: secureData) {
                        print("PokemonList: ", pokemonList)
                        
                        delegate?.showPokemonList(list: pokemonList)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func JSONParse(pokemonDates: Data) -> [Pokemon]? {
        let decodificador = JSONDecoder()
        
        do {
            let decodeDates = try decodificador.decode([Pokemon].self, from: pokemonDates)
            
            return decodeDates
        } catch {
            print("Error al decodificar datos: ", error.localizedDescription)
            return nil
        }
    }
}

extension Data {
    func parseData(quitarString word: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
