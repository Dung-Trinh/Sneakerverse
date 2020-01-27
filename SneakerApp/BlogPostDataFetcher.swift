//
//  BlogPostDataFetcher.swift
//  SneakerApp
//
//  Created by Dung  on 25.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import Foundation
import UIKit
class BlogPostDataFetcher {
    var blogPosts:[BlogPost]=[]
    var fetchSuccessfull = true

    func fetchBlogPostData(){
        blogPosts.removeAll()
        let semaphore = DispatchSemaphore(value: 0)
        
        ///fetch data
        fetchBlogPostJSON { (res) in
            semaphore.signal()

             switch res {
             case .success(let article):
                 article.forEach({ (article) in
                     self.blogPosts.append(article)
                    self.fetchSuccessfull = true
                 })
             case .failure(let err):
            print("Failed to fetch courses:", err)
                self.fetchSuccessfull = false


             }

            print(self.blogPosts)

         }
        semaphore.wait()

    }
    
    
        fileprivate func fetchBlogPostJSON(completion: @escaping (Result<[BlogPost], Error>) -> ()) {
            let urlString = "https://flasksneakerapi.herokuapp.com/blog"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                
                if let err = err {
                    completion(.failure(err))
                    self.fetchSuccessfull = false

                    return
                }
                
                // successful
                do {
                    let article = try JSONDecoder().decode([BlogPost].self, from: data!)
                    completion(.success(article))
                    
                } catch let jsonError {
                    completion(.failure(jsonError))
                    self.fetchSuccessfull = false
                }
                
                
            }.resume()
        }
}
