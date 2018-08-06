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
    var overlayView:UIView!
    fileprivate var characterToDisplay:CharacterDetails!
    func renderCharacter(characterDetails:CharacterDetails){
        if(characterDetails.thumbnailPath != nil){
            characterToDisplay = characterDetails
            let url = URL(string: characterDetails.thumbnailPath + "." + characterDetails.thumbnailExtenstion)
            self.characterThumbnail.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
            self.characterThumbnail.addGestureRecognizer(tapGesture)
            self.characterThumbnail.kf.setImage(with: url)
        }
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        
        
        self.overlayView = UIView(frame: (UIApplication.shared.keyWindow?.frame)!)
        let imageView : UIImageView = UIImageView(image: (gesture.view as! UIImageView).image)
        let screenBounds = UIScreen.main.bounds
        imageView.frame = CGRect(x: 50,y: 80,width: screenBounds.width-100,height:screenBounds.height-140)
        let resourceTitleLabel : UILabel = UILabel(frame: CGRect(x:70,y:screenBounds.height-50,width:screenBounds.width-80,height:70))
        resourceTitleLabel.textColor = UIColor.white
        resourceTitleLabel.text = self.characterToDisplay.title
        let closeImage = UIImage(named: "Close Icon")
        let closeBtn : UIButton = UIButton(frame: CGRect(x:screenBounds.width-50,y:40,width:50,height:50))
        closeBtn.setImage(closeImage, for: .normal)
        closeBtn.addTarget(self, action: #selector(self.pressed), for: .touchDown)
        
        self.overlayView.addSubview(closeBtn)
        self.overlayView.addSubview(imageView)
        self.overlayView.addSubview(resourceTitleLabel)
        self.overlayView.backgroundColor = UIColor.init(red: 60/255, green: 63/255, blue: 67/255, alpha: 1.0)
        UIApplication.shared.keyWindow?.addSubview(self.overlayView)
        self.characterThumbnail.superview?.superview?.alpha = 0.2
        
    }
    
    @objc func pressed(sender: UIButton!) {
        self.characterThumbnail.superview?.superview?.alpha = 1.0
        self.overlayView.removeFromSuperview()
    }
}
