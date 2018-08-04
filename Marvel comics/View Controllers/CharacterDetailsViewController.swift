//
//  CharacterDetailsViewController.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import UIKit
import Kingfisher
class CharacterDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var marvelCharacter:MarvelCharacter!
    var characterComics = [CharacterDetails]()
    var characterStories = [CharacterDetails]()
    var characterEvents = [CharacterDetails]()
    var characterSeries = [CharacterDetails]()
    
    var characterDetailsPresenter:CharacterDetailsPresenter!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    @IBOutlet weak var characterThumbnail: UIImageView!
    
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDesciption: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.comicsCollectionView.delegate = self
        self.comicsCollectionView.dataSource = self
        self.setLabels()
        characterDetailsPresenter = CharacterDetailsPresenter(characterDetailsView: self)
        characterDetailsPresenter.loadCharacterDetails(characterID: self.marvelCharacter.id)
    }
    
    func setLabels(){
        let url = URL(string: marvelCharacter.thumbnailPath + "." + marvelCharacter.thumbnailExtenstion)
        self.characterThumbnail.kf.setImage(with: url)
        self.characterName.text = marvelCharacter.name
        self.characterDesciption.text = marvelCharacter.description
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterComics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterDetailsCollectionViewCell", for: indexPath) as! CharacterDetailsCollectionViewCell
        cell.renderCharacter(characterDetails: self.characterComics[indexPath.row])
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CharacterDetailsViewController:CharacterDetailsView{
    func startLoading() {
        BusyLoader.showBusyIndicator(mainView: self.view)
    }
    
    func finishLoading() {
        BusyLoader.hideBusyIndicator()
    }
    
    func setCharacterComics(characterComics: [CharacterDetails]) {
        self.characterComics = characterComics
        print("Comics loaded")
        self.comicsCollectionView.reloadData()
    }
    
    func setCharacterStories(characterStories: [CharacterDetails]) {
        self.characterStories = characterStories
    }
    
    func setCharacterEvents(characterEvents: [CharacterDetails]) {
        self.characterEvents = characterEvents
    }
    
    func setCharacterSeries(characterSeries: [CharacterDetails]) {
        self.characterSeries = characterSeries
    }
    
    func setErrorLoading(status: String) {
        
    }
    
    
}
