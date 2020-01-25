//
//  CoreDataManager.swift
//  SneakerApp
//
//  Created by Van Anh Kasem on 25.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager{
    
    func saveBlogpost(blogPost:BlogPost?){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                   return
               }
              let context = appDelegate.persistentContainer.viewContext
               let entityName="BlogpostData" // Tabellenname im Datenmodell
              // Neuen Datensatz anlegen
               guard let newEntity = NSEntityDescription.entity(forEntityName: entityName, in: context)else{
                   return
               }
               let savedBlogpost = NSManagedObject(entity:newEntity,insertInto: context)
               
                let title=blogPost?.title
                let text = blogPost?.description
                let category = blogPost?.category
                let contentPictures = blogPost?.contentPictures
                let contentVideo = blogPost?.contentVideo
                let cover = blogPost?.cover
                let shareLink = blogPost?.shareLink
               
                savedBlogpost.setValue(title, forKey: "title")
                savedBlogpost.setValue(text, forKey: "text")
                savedBlogpost.setValue(category, forKey: "category")
                savedBlogpost.setValue(contentVideo, forKey: "contentVideo")
                savedBlogpost.setValue(cover, forKey: "cover")
                savedBlogpost.setValue(shareLink, forKey: "shareLink")
                savedBlogpost.setValue(contentPictures, forKey: "contentPictures")
                
                do{
                    try context.save()
                      print(savedBlogpost)
                }catch{
                    print(error)
                }
    }
    
    func deleteBlogpost(blogPost:BlogPost?){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                   return
               }
               let context = appDelegate.persistentContainer.viewContext
               let entityName="BlogpostData"

               // Anfrage stellen
               let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let results = try context.fetch(request)
            guard results.count > 0 else {
                return
            }
            for blogpo in results as! [NSManagedObject]{
              
                if(blogpo.value(forKey: "title") as! String == blogPost?.title ){
                    context.delete(blogpo)
                }

                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
        }catch{
            print(error)
        }
    }
    
    
    func checkSavedBlogpost(blogPost:BlogPost?) -> Bool{
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let context = appDelegate.persistentContainer.viewContext
               let entityName="BlogpostData"

               // Anfrage stellen
               let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let results = try context.fetch(request)
            if(results.count > 0) {
                for blopo in results as! [NSManagedObject]{
                  if(blopo.value(forKey: "title") as! String == blogPost?.title ){
                          return true
                  }
              }
            }
        }catch{
            print(error)
        }
        return false
    }
    
    func checkSavedSneaker(sneaker:Sneaker?) -> Bool{
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
                 let context = appDelegate.persistentContainer.viewContext
                 let entityName="SneakerData"

                 // Anfrage stellen
                 let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
          do{
              let results = try context.fetch(request)
                if(results.count > 0){
                for snkr in results as! [NSManagedObject]{
                         if(snkr.value(forKey: "title") as! String == sneaker?.title ){
                                 return true
                         }
                     }
            }
          }catch{
              print(error)
          }
        return false
      }
    
    func deleteSneaker(sneaker:Sneaker?){
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                let context = appDelegate.persistentContainer.viewContext
                let entityName="SneakerData"

                // Anfrage stellen
                let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
         do{
             let results = try context.fetch(request)
             guard results.count > 0 else {
                 return
             }
             for snkr in results as! [NSManagedObject]{
                 if(snkr.value(forKey: "title") as! String == sneaker?.title ){
                     context.delete(snkr)
                 }

                 do{
                     try context.save()
                 }catch{
                     print(error)
                 }
                 
             }
         }catch{
             print(error)
         }
     }
    
    
    
    func saveSneaker(sneaker:Sneaker?){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                        return
                    }
                   let context = appDelegate.persistentContainer.viewContext
                    let entityName="SneakerData" // Tabellenname im Datenmodell
                   // Neuen Datensatz anlegen
                    guard let newEntity = NSEntityDescription.entity(forEntityName: entityName, in: context)else{
                        return
                    }
                    let savedSneaker = NSManagedObject(entity:newEntity,insertInto: context)
                    
                   let title=sneaker?.title
                   let text = sneaker?.description
                   let brand = sneaker?.brand
                   let imgArray = sneaker?.imgArray
                   let imageURL = sneaker?.imageURL
                   let position = sneaker?.position
                   let priceSpan = sneaker?.priceSpan
                   let releaseDate = sneaker?.releaseDate
                   let retailPrice = sneaker?.retailPrice
                            
                 savedSneaker.setValue(title, forKey: "title")
                 savedSneaker.setValue(text, forKey: "text")
                 savedSneaker.setValue(brand, forKey: "brand")
                 savedSneaker.setValue(imageURL, forKey: "imageURL")
                 savedSneaker.setValue(position, forKey: "position")
                 savedSneaker.setValue(priceSpan, forKey: "priceSpan")
                      savedSneaker.setValue(releaseDate, forKey: "releaseDate")
                      savedSneaker.setValue(retailPrice, forKey: "retailPrice")
                      savedSneaker.setValue(imgArray, forKey: "imgArray")
                 
                 do{
                     try context.save()
                       print(savedSneaker)
          //             context.delete(savedSneaker)
          //             print("Gelöscht")
                 }catch{
                     print(error)
                 }
    }
}
