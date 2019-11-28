//
//  NewsArticleRequest.swift
//  SneakerApp
//
//  Created by Dung  on 22.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import Foundation
import UIKit
enum FetchError: Error{
    case noData
}

struct NewsArticleRequest{
    let resourceURL:URL
    
    init(data:String) {
        
        let resourceString="https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL=resourceURL
    }
    
    func getData (completion: @escaping (Result<[BlogPost], FetchError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL){
            data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
        }
        dataTask.resume()
    }
}
