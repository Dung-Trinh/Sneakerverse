//
//  NewsPost.swift
//  SneakerApp
//
//  Created by Dung  on 10.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import Foundation
class NewsPost:Decodable{
    var title : String
    var category : String
    var description : String
    var cover : String /// image link
    var contentImages : [String ]
    var shareLink : String
    var contentVideos: String?
    


    init(title:String,category:String,description:String,cover:String,contentImages:[String],shareLink:String,contentVideos:String?) {
            self.title = title
            self.category = category
            self.description = description
            self.cover = cover
            self.contentImages = contentImages
            self.shareLink = shareLink
            self.contentVideos = contentVideos
    }
}

