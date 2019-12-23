//
//  NewsArticle.swift
//  SneakerApp
//
//  Created by Dung  on 22.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import Foundation
import CoreData

struct BlogPost:Decodable{
    var title : String
    var cover : String
    var category:String
    var description:String
    var contentPictures:[String]
    var shareLink:String
    var contentVideo :String
}
