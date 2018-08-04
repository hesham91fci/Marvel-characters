//
//  CharacterDetailsPresenter.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/4/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import Foundation
protocol CharacterDetailsView : NSObjectProtocol{
    func setCharacterComics(characterComics:[CharacterDetails])
    func setCharacterStories(characterStories:[CharacterDetails])
    func setCharacterEvents(characterEvents:[CharacterDetails])
    func setCharacterSeries(characterSeries:[CharacterDetails])
    func setErrorLoading(status:String)
}

class CharacterDetailsPresenter{
    var characterDetailsView:CharacterDetailsView!
    init(characterDetailsView:CharacterDetailsView) {
        self.characterDetailsView = characterDetailsView
    }
    func loadCharacterDetails(characterID:Int){
        DispatchQueue.main.async {
            self.loadCharacterComics(characterID: characterID)
            self.loadCharacterEvents(characterID: characterID)
            self.loadCharacterSeries(characterID: characterID)
            self.loadCharacterStories(characterID: characterID)
        }
    }
    
    fileprivate func loadCharacterComics(characterID:Int){
        MarvelRepository.sharedMarvelRepository.getMarvelCharacterDetailsRepository().loadMarvelResource(characterID: characterID, resource: "comics") { (status, marvelComics) in
            if(!status.isEmpty){
                self.characterDetailsView.setErrorLoading(status: status)
            }
            else{
                self.characterDetailsView.setCharacterComics(characterComics: marvelComics)
            }
        }
    }
    
    fileprivate func loadCharacterStories(characterID:Int){
        MarvelRepository.sharedMarvelRepository.getMarvelCharacterDetailsRepository().loadMarvelResource(characterID: characterID, resource: "stories") { (status, marvelStories) in
            if(!status.isEmpty){
                self.characterDetailsView.setErrorLoading(status: status)
            }
            else{
                self.characterDetailsView.setCharacterStories(characterStories: marvelStories)
            }
        }
    }
    
    fileprivate func loadCharacterEvents(characterID:Int){
        MarvelRepository.sharedMarvelRepository.getMarvelCharacterDetailsRepository().loadMarvelResource(characterID: characterID, resource: "events") { (status, marvelEvents) in
            if(!status.isEmpty){
                self.characterDetailsView.setErrorLoading(status: status)
            }
            else{
                self.characterDetailsView.setCharacterEvents(characterEvents: marvelEvents)
            }
        }
    }
    
    fileprivate func loadCharacterSeries(characterID:Int){
        MarvelRepository.sharedMarvelRepository.getMarvelCharacterDetailsRepository().loadMarvelResource(characterID: characterID, resource: "series") { (status, marvelSeries) in
            if(!status.isEmpty){
                self.characterDetailsView.setErrorLoading(status: status)
            }
            else{
                self.characterDetailsView.setCharacterSeries(characterSeries: marvelSeries)
            }
        }
    }
}
