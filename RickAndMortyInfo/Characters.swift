//
//  Characters.swift
//  RickAndMortyInfo
//
//  Created by John Connolly on 4/25/19.
//  Copyright © 2019 John Connolly. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Characters {
    
    var characterArray: [CharacterInfo] = []
    var apiURL = "https://rickandmortyapi.com/api/character/?page=1"
    var pageNumber = 1
    var totalCharacters = 0
    
    func getCharacters() {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfCharacters = json["results"].count
                self.apiURL = json["info"]["next"].stringValue
                self.totalCharacters = json["info"]["count"].intValue
                for index in 0..<numberOfCharacters {
                    let name = json["results"]["name"].stringValue
                    let status = json["results"]["status"].stringValue
                    let species = json["results"]["species"].stringValue
                    let gender = json["results"]["gender"].stringValue
                    let type = json["results"]["type"].stringValue
                    let origin = json["results"]["origin"]["name"].stringValue
                    let location = json["results"]["location"]["name"].stringValue
                    let image = json["results"]["image"].stringValue
                    print("\(name), \(gender)")
                }
            case .failure(let error):
                print("😡 Error: \(error.localizedDescription) failed to get data from url \(self.apiURL)")
            }
        }
    }
}












