//
//  SneakerDataFetcher.swift
//  SneakerApp
//
//  Created by Dung  on 25.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import Foundation
import UIKit

class SneakerDataFetcher{
    var allSneaker:[Sneaker]=[]
    var sneakerCalenderBottom:[Sneaker]=[]
    var sneakerCalenderTop:[Sneaker]=[]
    var fetchSuccessfull = true
    
    func fetchSneakerData() {
        self.clearData()
        let semaphore = DispatchSemaphore(value: 0)

        self.fetchSneaker { (res) in
            semaphore.signal()

            switch res {
            case .success(let article):
               article.forEach({ (article) in
                    self.allSneaker.append(article)
                self.fetchSuccessfull = true
                })
            case .failure(let err):
                print("Failed to fetch courses:", err)
                self.fetchSuccessfull = false
               
            }
            //einfügen der schuhe
            for s in self.allSneaker{
              if s.position == "bottom"{
                self.sneakerCalenderBottom.append(s)
              }else if s.position == "top"{
                self.sneakerCalenderTop.append(s)
                }
          }
  
            self.sortSneaker(sneakers: &self.sneakerCalenderBottom)
            self.sortSneaker(sneakers: &self.sneakerCalenderTop)
        }
        semaphore.wait()

    }

    fileprivate func fetchSneaker(completion:@escaping(Result<[Sneaker],Error>)-> Void){

        let urlString = "https://flasksneakerapi.herokuapp.com/sneakers"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in

                       
                       if let err = err {
                           completion(.failure(err))
                           return
                       }
                       
                       // successful
                       do {
                        print("ERFOLLG")
                        let article = try JSONDecoder().decode([Sneaker].self, from: data!)
                           completion(.success(article))
           //                completion(courses, nil)
                           
                       } catch let jsonError {
                           completion(.failure(jsonError))
                        print(jsonError.localizedDescription)
                        self.fetchSuccessfull = false

           //                completion(nil, jsonError)
                       }
                       

                   }.resume()
    }
    /// inout to
    func sortSneaker(sneakers:inout [Sneaker]){
        sneakers.sort {
            let splitLine: [String]?
            let splitLine2 : [String]?

            if $0.releaseDate.contains("."){
                splitLine = $0.releaseDate.components(separatedBy: ".")
            }else{
                splitLine = $0.releaseDate.components(separatedBy: "/")
            }
            
            
            if $1.releaseDate.contains("."){
                splitLine2 = $1.releaseDate.components(separatedBy: ".")
            }else{
                splitLine2 = $1.releaseDate.components(separatedBy: "/")
            }
            return splitLine![1] < splitLine2![1]
            
        }
}

    
    func clearData() {
        self.allSneaker.removeAll()
        self.sneakerCalenderBottom.removeAll()
        self.sneakerCalenderTop.removeAll()
    }
    
}
