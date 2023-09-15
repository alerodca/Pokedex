//
//  PokemonDetailViewController.swift
//  Pokedex_v2
//
//  Created by Alejandro Rodríguez Cañete on 14/9/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var pokemonTitle: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonDescription: UITextView!
    @IBOutlet weak var pokemonAttack: UILabel!
    @IBOutlet weak var pokemonDefense: UILabel!
    
    // MARK: - Variables
    
    var showPokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonTitle.text = showPokemon?.name ?? ""
        pokemonType.text = "Type: \(showPokemon?.type ?? "")"
        pokemonDescription.text = showPokemon?.description ?? ""
        pokemonAttack.text = "Attack: \(showPokemon!.attack)"
        pokemonDefense.text = "Defense: \(showPokemon!.defense)"
        pokemonImage.loadFrom(URLAddress: showPokemon?.imageUrl ?? "")
    }

}

extension UIImageView {
    
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                print("Error al cargar la imagen desde la URL: \(error)")
                return
            }
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = loadedImage
                }
            }
        }
        task.resume()
    }
    
//    func loadFrom(URLAdress: String) {
//        guard let url = URL(string: URLAdress) else { return }
//        DispatchQueue.main.async { [weak self] in
//            if let imageData = try? Data(contentsOf: url) {
//                if let loadedImage = UIImage(data: imageData) {
//                    self?.image = loadedImage
//                }
//            }
//        }
//    }
}
