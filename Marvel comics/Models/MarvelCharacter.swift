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
    static var totalCharactersPerCall:Int!
    static var totalCharacters:Int!
    var id:Int!
    var name:String!
    var thumbnailPath:String!
    var thumbnailExtenstion:String!
    var description:String!
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name    <- map["name"]
        thumbnailPath         <- map["thumbnail.path"]
        thumbnailExtenstion      <- map["thumbnail.extension"]
        description      <- map["description"]
    }
}
