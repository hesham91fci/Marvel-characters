//
//  MarvelComic.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/4/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import Foundation
import ObjectMapper
class MarvelComic : Mappable{
    var thumbnailPath:String!
    var thumbnailExtenstion:String!
    var title:String!
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title    <- map["title"]
        thumbnailPath         <- map["thumbnail.path"]
        thumbnailExtenstion      <- map["thumbnail.extension"]
    }
    
}
