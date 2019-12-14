//
//  Sneaker.swift
//  SneakerApp
//
//  Created by Dung  on 30.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import Foundation
import UIKit

class Sneaker {
    init(title:String,date:String,img:UIImage,brand:String) {
        self.titel = title
        self.date = date
        self.img = img
        self.brand = brand
    }
    
    var titel :String!
    var date : String!
    var img : UIImage!
    var brand : String!
}
