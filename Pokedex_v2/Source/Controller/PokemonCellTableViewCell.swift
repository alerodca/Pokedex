//
//  PokemonCellTableViewCell.swift
//  Pokedex_v2
//
//  Created by Alejandro Rodríguez Cañete on 14/9/23.
//

import UIKit

class PokemonCellTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonDefense: UILabel!
    @IBOutlet weak var pokemonAttack: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pokemonImage.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
