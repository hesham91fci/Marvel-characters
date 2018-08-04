//
//  MarvelCharacterDetailsRepository.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/4/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
class MarvelCharacterDetailsRepository: CharacterDetailsRepository {
    func loadMarvelResource(characterID:Int,resource:String, completionHandler: @escaping (_ errorDescription: String, _ data: [CharacterDetails]) -> Void){
        let keys = MarvelRepository.sharedMarvelRepository.getKeys()
        let urlPath = NSLocalizedString("HOST_URL", comment: "comment") + String(format: NSLocalizedString("COMICS_ENDPOINT", comment: "comment"), characterID,resource)
        let ts = NSDate().timeIntervalSince1970.description
        let params: Parameters = [
                "apikey": keys["public key"]!,
                "ts": ts,
                "hash": (ts + keys["private key"]! + keys["public key"]!).md5(),
        ]
        
        Alamofire.request(URL(string: urlPath)!,
                          method: .get,
                          parameters: params)
            .validate()
            .responseJSON { response in
                if(response.result.isSuccess) {
                    let JSONResponse = response.value as! [String:Any]
                    let dataResponse = JSONResponse["data"] as! [String:Any]
                    let marvelDetails = Mapper<CharacterDetails>().mapArray(JSONArray: dataResponse["results"] as! [[String : Any]])
                    completionHandler("", marvelDetails)
                }
                else{
                    completionHandler("", [])
                }
        }
    }
    
}
