//
//  MarvelCharactersRepositories.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift
class MarvelCharactersRepository : CharacterRepository{
    func loadMarvelCharacters(completionHandler: @escaping (_ errorDescription: String, _ data: [MarvelCharacter]) -> Void){
        
        let keys = MarvelRepository.sharedMarvelRepository.getKeys()
        let urlPath = NSLocalizedString("HOST_URL", comment: "comment") + NSLocalizedString("CHARACTER_ENDPOINT", comment: "comment")
        let ts = NSDate().timeIntervalSince1970.description
        
        let params: Parameters = [
            "apikey": keys["public key"]!,
            "ts": ts,
            "hash": (ts + keys["private key"]! + keys["public key"]!).md5()
        ]
        
        Alamofire.request(URL(string: urlPath)!,
                          method: .get,
                          parameters: params)
            .validate()
            .responseJSON { response in
                if(!response.result.isSuccess) {
                    completionHandler("", [])
                }
                else{
                    completionHandler("", [])
                }
        }
        
    }
    
}
