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
    var apiURL = "https://rickandmortyapi.com/api/character/"
    var pageNumber = 1
    var totalCharacters = 0
    
    func getCharacters(completed: @escaping () -> ()) {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfCharacters = json["results"].count
                self.apiURL = json["info"]["next"].stringValue
                self.totalCharacters = json["info"]["count"].intValue
                for index in 0..<numberOfCharacters {
                    let name = json["results"][index]["name"].stringValue
                    let status = json["results"][index]["status"].stringValue
                    let species = json["results"][index]["species"].stringValue
                    let gender = json["results"][index]["gender"].stringValue
                    let type = json["results"][index]["type"].stringValue
                    let origin = json["results"][index]["origin"]["name"].stringValue
                    let location = json["results"][index]["location"]["name"].stringValue
                    let image = json["results"][index]["image"].stringValue
                    self.characterArray.append(CharacterInfo(name: name, status: status, species: species, type: type, gender: gender, origin: origin, location: location, image: image))
                    
                }
            case .failure(let error):
                print("😡 Error: \(error.localizedDescription) failed to get data from url \(self.apiURL)")
            }
            completed()
        }
    }
}












