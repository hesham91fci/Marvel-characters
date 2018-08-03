//
//  CharacterTableViewCell.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/3/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import UIKit
import Kingfisher
class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterThumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func renderCharacter(marvelCharacter:MarvelCharacter){
        let url = URL(string: marvelCharacter.thumbnailPath + "." + marvelCharacter.thumbnailExtenstion)
        self.characterThumbnail.kf.setImage(with: url)
        nameLabel.text = marvelCharacter.name
    }

}
