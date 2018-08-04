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
import ObjectMapper
class MarvelCharactersRepository : CharacterRepository{
    func loadMarvelCharacters(offest offset:Int,name:String?, completionHandler: @escaping (_ errorDescription: String, _ data: [MarvelCharacter]) -> Void){
        
        let keys = MarvelRepository.sharedMarvelRepository.getKeys()
        let urlPath = NSLocalizedString("HOST_URL", comment: "comment") + NSLocalizedString("CHARACTER_ENDPOINT", comment: "comment")
        let ts = NSDate().timeIntervalSince1970.description
        let params: Parameters = (name != nil) ? [
            "apikey": keys["public key"]!,
            "ts": ts,
            "name":name!,
            "hash": (ts + keys["private key"]! + keys["public key"]!).md5(),
            "offset":"\(offset)"
            ]:
        [
            "apikey": keys["public key"]!,
            "ts": ts,
            "hash": (ts + keys["private key"]! + keys["public key"]!).md5(),
            "offset":"\(offset)"
        ]
        
        Alamofire.request(URL(string: urlPath)!,
                          method: .get,
                          parameters: params)
            .validate()
            .responseJSON { response in
                if(response.result.isSuccess) {
                    let JSONResponse = response.value as! [String:Any]
                    let dataResponse = JSONResponse["data"] as! [String:Any]
                    MarvelCharacter.totalCharactersPerCall = dataResponse["limit"] as! Int
                    if(MarvelCharacter.totalCharacters==nil){
                        MarvelCharacter.totalCharacters = dataResponse["total"] as! Int
                    }
                    let marvelCharacters = Mapper<MarvelCharacter>().mapArray(JSONArray: dataResponse["results"] as! [[String : Any]])
                    completionHandler("", marvelCharacters)
                }
                else{
                    completionHandler("", [])
                }
        }
        
    }
    
}
