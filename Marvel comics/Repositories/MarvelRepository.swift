//
//  MarvelRepository.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import Foundation
class MarvelRepository{
    static let sharedMarvelRepository=MarvelRepository()
    fileprivate var marvelCharacterRepository:MarvelCharactersRepository
    fileprivate var marvelCharacterDetailsRepository:MarvelCharacterDetailsRepository
    fileprivate var keys: Dictionary<String, String>!
    
    fileprivate init(){
        marvelCharacterRepository = MarvelCharactersRepository()
        marvelCharacterDetailsRepository = MarvelCharacterDetailsRepository()
    }
    
    func getKeys() -> Dictionary<String, String> {
        if let path = Bundle.main.path(forResource: "Marvel Keys", ofType: "plist") {
            self.keys = NSDictionary(contentsOfFile: path) as! Dictionary<String, String>
        }
        return self.keys
    }
    
    func getMarvelCharactersRepository() -> MarvelCharactersRepository{
        return marvelCharacterRepository
    }
    
    func getMarvelCharacterDetailsRepository() -> MarvelCharacterDetailsRepository{
        return marvelCharacterDetailsRepository
    }
}
