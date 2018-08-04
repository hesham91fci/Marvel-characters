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
    
    func renderCharacter(marvelCharacter:MarvelCharacter){
        let url = URL(string: marvelCharacter.thumbnailPath + "." + marvelCharacter.thumbnailExtenstion)
        self.characterThumbnail.kf.setImage(with: url)
    }
}
