//
//  CharacterRepository.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import Foundation
protocol CharacterRepository {
    func loadMarvelCharacters(offest offset:Int,name:String?, completionHandler: @escaping (_ errorDescription: String, _ data: [MarvelCharacter]) -> Void)
}

extension CharacterRepository {
    func loadMarvelCharacters(offest offset:Int,name:String?=nil, completionHandler: @escaping (_ errorDescription: String, _ data: [MarvelCharacter]) -> Void){
        return loadMarvelCharacters(offest: offset, name: name, completionHandler: completionHandler)
    }
}
