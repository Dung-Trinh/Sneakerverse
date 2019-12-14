//
//  FetchData.swift
//  SneakerApp
//
//  Created by Dung  on 10.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import Foundation
import UIKit
class FetchData{
    var blogPosts:[BlogPost] = [ ]
    
    func fetchBlogPosts() {
         fetchCoursesJSON { (res) in
              switch res {
              case .success(let article):
                  article.forEach({ (article) in
                      print(article.title)
                      print(article.imageURL)
                      self.blogPosts.append(article)
                  })
              case .failure(let err):
                  print("Failed to fetch courses:", err)
              }
          }
    }
    
        fileprivate func fetchCoursesJSON(completion: @escaping (Result<[BlogPost], Error>) -> ()) {
            let urlString = "http://127.0.0.1:5000/news"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                
                if let err = err {
                    completion(.failure(err))
                    return
                }
                
                // successful
                do {
                    let article = try JSONDecoder().decode([BlogPost].self, from: data!)
                    completion(.success(article))
    //                completion(courses, nil)
                    
                } catch let jsonError {
                    completion(.failure(jsonError))
    //                completion(nil, jsonError)
                }
                
                
            }.resume()
        }
    
}
