//
//  CharacterPresenter.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import Foundation

protocol CharacterView : NSObjectProtocol{
    func startLoading()
    func finishLoading()
    func setCharacters(marvelCharacters:[MarvelCharacter])
    func setCharacterDetails(marvelCharacter:MarvelCharacter)
    func setErrorLoading(status:String)
}

class CharacterPresenter{
    var characterView:CharacterView!
    init(characterView:CharacterView) {
        self.characterView = characterView
    }
    func loadMarvelCharacters(){
        characterView.startLoading()
        MarvelRepository.sharedMarvelRepository.getMarvelCharactersRepository().loadMarvelCharacters { (status, marvelCharacters) in
            self.characterView.finishLoading()
            if(!status.isEmpty){
                self.characterView.setErrorLoading(status: status)
            }
            else{
                self.characterView.setCharacters(marvelCharacters: marvelCharacters)
            }
        }
    }

}
