//
//  CharacterDetailsCollectionViewCell.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/4/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import UIKit

class CharacterDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterThumbnail: UIImageView!
    
    func renderCharacter(characterDetails:CharacterDetails){
        let url = URL(string: characterDetails.thumbnailPath + "." + characterDetails.thumbnailExtenstion)
        self.characterThumbnail.kf.setImage(with: url)
    }
}
