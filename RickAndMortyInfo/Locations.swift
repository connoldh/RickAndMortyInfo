//
//  Locations.swift
//  RickAndMortyInfo
//
//  Created by John Connolly on 4/26/19.
//  Copyright © 2019 John Connolly. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Locations {
    
    var locationArray: [LocationInfo] = []
    var apiLocationURL = "https://rickandmortyapi.com/api/location"
    var pageNumber = 1
    var totalLocations = 0
    
    func getLocations(completed: @escaping () -> ()) {
        Alamofire.request(apiLocationURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfLocations = json["results"].count
                self.apiLocationURL = json["info"]["next"].stringValue
                self.totalLocations = json["info"]["count"].intValue
                for index in 0..<numberOfLocations {
                    let name = json["results"][index]["name"].stringValue
                    let type = json["results"][index]["type"].stringValue
                    let dimension = json["results"][index]["dimension"].stringValue
                    let residents = json["results"][index]["residents"].stringValue
                    print("\(name)")
                    self.locationArray.append(LocationInfo(name: name, type: type, dimension: dimension, residents: residents))
                }
            case .failure(let error):
                print("😡 Error: \(error.localizedDescription) failed to get data from url \(self.apiLocationURL)")
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
