//
//  SneakerDetail.swift
//  SneakerApp
//
//  Created by Dung  on 22.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import Foundation
import CoreData


struct SneakerDetail:Decodable{
    var title:String
    var imageURL : String
    var retailPrice : String
    var priceSpan : String
    var releaseDate : String
}
