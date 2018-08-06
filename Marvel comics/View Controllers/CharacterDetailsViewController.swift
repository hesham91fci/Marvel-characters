//
//  CharacterDetailsViewController.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import UIKit
import Kingfisher
struct ActiveResource{
    let characterDetails:[CharacterDetails]
    let detailsLabel:UILabel!
}
class CharacterDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var marvelCharacter:MarvelCharacter!
    
    var characterDetailsPresenter:CharacterDetailsPresenter!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var characterThumbnail: UIImageView!
    
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDesciption: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var relatedLinksTableView: UITableView!
    
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var storiesLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!
    
    var collectionViewsDictionary = Dictionary<UICollectionView,ActiveResource>()
    let relatedLinks = ["Detail","Wiki","Comic Link"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLabels()
        self.setCollectionViewsProperties()
        self.setTableViewsProperties()
        self.relatedLinksTableView.reloadData()
        characterDetailsPresenter = CharacterDetailsPresenter(characterDetailsView: self)
        characterDetailsPresenter.loadCharacterDetails(characterID: self.marvelCharacter.id)
    }
    
    func setTableViewsProperties(){
        self.relatedLinksTableView.delegate = self
        self.relatedLinksTableView.dataSource = self
    }
    
    func setCollectionViewsProperties(){
        self.comicsCollectionView.delegate = self
        self.comicsCollectionView.dataSource = self
        self.storiesCollectionView.delegate = self
        self.seriesCollectionView.delegate = self
        self.eventsCollectionView.delegate = self
        
        self.storiesCollectionView.dataSource = self
        self.seriesCollectionView.dataSource = self
        self.eventsCollectionView.dataSource = self
    }
    
    func setLabels(){
        let url = URL(string: marvelCharacter.thumbnailPath + "." + marvelCharacter.thumbnailExtenstion)
        self.characterThumbnail.kf.setImage(with: url)
        self.characterName.text = marvelCharacter.name
        if(!marvelCharacter.description.isEmpty){
            self.characterDesciption.text = marvelCharacter.description
        }
        else{
            self.descriptionLabel.isHidden = true
            self.characterDesciption.isHidden = true
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.collectionViewsDictionary[collectionView] == nil){
            return 0
        }
        if(self.collectionViewsDictionary[collectionView]?.characterDetails.count == 0){
            self.collectionViewsDictionary[collectionView]?.detailsLabel.isHidden = true
        }
        return self.collectionViewsDictionary[collectionView]!.characterDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterDetailsCollectionViewCell", for: indexPath) as! CharacterDetailsCollectionViewCell
        cell.renderCharacter(characterDetails: self.collectionViewsDictionary[collectionView]!.characterDetails[indexPath.row])
        return cell
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CharacterDetailsViewController:CharacterDetailsView{
    func setCharacterComics(characterComics: [CharacterDetails]) {
        
        self.reloadActiveCollectionView(activeCollectionView: self.comicsCollectionView, activeResource: ActiveResource(characterDetails: characterComics, detailsLabel: self.comicsLabel))
    }
    
    func setCharacterStories(characterStories: [CharacterDetails]) {
        
        
        self.reloadActiveCollectionView(activeCollectionView: self.storiesCollectionView, activeResource: ActiveResource(characterDetails: characterStories, detailsLabel: self.storiesLabel))
    }
    
    func setCharacterEvents(characterEvents: [CharacterDetails]) {
        self.reloadActiveCollectionView(activeCollectionView: self.eventsCollectionView, activeResource: ActiveResource(characterDetails: characterEvents, detailsLabel: self.eventsLabel))
    }
    
    func setCharacterSeries(characterSeries: [CharacterDetails]) {
        
        self.reloadActiveCollectionView(activeCollectionView: self.seriesCollectionView, activeResource: ActiveResource(characterDetails: characterSeries, detailsLabel: self.seriesLabel))
    }
    
    func reloadActiveCollectionView(activeCollectionView:UICollectionView, activeResource:ActiveResource){
        collectionViewsDictionary[activeCollectionView] = activeResource
        activeCollectionView.reloadData()
    }
    
    func setErrorLoading(status: String) {
        
    }
    
    
}

extension CharacterDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.relatedLinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedLinksTableViewCell", for: indexPath) as! RelatedLinksTableViewCell
        cell.linkLabel.text = self.relatedLinks[indexPath.row]
        return cell
    }
    
    
}
