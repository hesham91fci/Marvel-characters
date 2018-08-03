//
//  MarvelCharacter.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import Foundation
import ObjectMapper
class MarvelCharacter: Mappable{
    var thumbnailPath:String!
    var name:String!
    var thumbnailExtenstion:String!
    static var totalCharactersPerCall:Int!
    static var totalCharacters:Int!
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        thumbnailPath         <- map["thumbnail.path"]
        thumbnailExtenstion      <- map["thumbnail.extension"]
    }
}
