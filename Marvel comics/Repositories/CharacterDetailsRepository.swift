//
//  CharacterDetailsRepository.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/4/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import Foundation
protocol CharacterDetailsRepository {
    func loadMarvelResource(characterID:Int,resource:String, completionHandler: @escaping (_ errorDescription: String, _ data: [CharacterDetails]) -> Void)
}
