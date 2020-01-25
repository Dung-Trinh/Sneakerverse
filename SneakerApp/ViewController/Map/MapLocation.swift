//
//  MapLocation.swift
//  SneakerApp
//
//  Created by Dung  on 24.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import Foundation
import UIKit

struct MapLocation:Decodable {
    var name:String
    var latitude : Double
    var longitude : Double
    var logoName : String //name of image
    var locationType : String
    var address : String
    
    init(name:String,latitude:Double,longitude : Double,logoName:String,locationType:String,address:String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.logoName = logoName
        self.locationType = locationType
        self.address = address
    }
    init(json : [String:Any]){
        self.name = json["name"] as? String ?? ""
        self.latitude = json["latitude"] as? Double ?? -1.0
        self.longitude = json["longitude"] as? Double ?? -1.0
        self.logoName = json["logoName"] as? String ?? "error_img"
        self.locationType = json["locationType"] as? String ?? "Error"
        self.address = json["address"] as? String ?? "Error"
    }
}
