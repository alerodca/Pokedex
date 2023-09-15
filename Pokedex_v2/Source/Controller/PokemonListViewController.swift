//
//  ViewController.swift
//  Pokedex_v2
//
//  Created by Alejandro Rodríguez Cañete on 14/9/23.
//

import UIKit

class PokemonListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    var pokemonManager = PokemonManager()
    var pokemons: [Pokemon] = []
    var pokemonSelected: Pokemon?
    var pokemonsFiltered: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PokemonCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        pokemonManager.delegate = self
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        pokemonManager.showPokemon()
        
        pokemonsFiltered = pokemons
    }


}

extension PokemonListViewController: pokemonManagerDelegate {
    func showPokemonList(list: [Pokemon]) {
        pokemons = list
        
        DispatchQueue.main.async {
            self.pokemonsFiltered = self.pokemons
            self.tableView.reloadData()
        }
    }
    
    
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonsFiltered = []
        
        if searchText == "" {
            pokemonsFiltered = pokemons
        } else {
            for poke in pokemons {
                if poke.name.lowercased().contains(searchText.lowercased()) {
                    pokemonsFiltered.append(poke)
                }
            }
        }
        
        self.tableView.reloadData()
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonCellTableViewCell
        cell.pokemonName?.text = pokemonsFiltered[indexPath.row].name
        cell.pokemonAttack.text = "Attack: \(pokemonsFiltered[indexPath.row].attack)"
        cell.pokemonDefense.text = "Defense: \(pokemonsFiltered[indexPath.row].defense)"
        
        if let urlString = pokemonsFiltered[indexPath.row].imageUrl as? String {
            if let imagenURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imagenURL) else { return }
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.pokemonImage.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pokemonSelected = pokemonsFiltered[indexPath.row]
        
        performSegue(withIdentifier: "showPokemonDetail", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPokemonDetail" {
            let showPokemonSent = segue.destination as! PokemonDetailViewController
            showPokemonSent.showPokemon = pokemonSelected
        }
    }
}
