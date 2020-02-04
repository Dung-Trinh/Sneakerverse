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
    var appDelegate:AppDelegate?
    var context:NSManagedObjectContext?
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = self.appDelegate!.persistentContainer.viewContext
    }
    
    func loadSavedCollection()->[savedPhoto]{
        var savedCollection : [savedPhoto] = []
          let entityName="MyCollectionData"
          
          // Anfrage stellen
          let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
          do{
            let results = try self.context!.fetch(request)
              for collectionData in results as! [NSManagedObject]{
                let sneakerName = collectionData.value(forKey: "sneakerName") as! String
                let data = collectionData.value(forKey: "picture")
                let picture = UIImage.init(data: data as! Data)
                 let collectionPhoto=savedPhoto(picture: picture, sneakerName: sneakerName)
                savedCollection.append(collectionPhoto)
                 
              }
              print ("Geladen: '\(results.count)' Collection Ergebnisse")
          }
          
          catch{
              print(error)
          }
        return savedCollection
    }
    func deleteEntireCollection(){
               let entityName="MyCollectionData"

               // Anfrage stellen
               let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                do{
                    let results = try context!.fetch(request)
                    guard results.count > 0 else {
                        return
                    }
                    for collectionData in results as! [NSManagedObject]{
                        context!.delete(collectionData)
                    }
                    do{
                        try context!.save()
                        print("Ganze Collection gelöscht")
                    }catch{
                        print(error)
                    }

                }catch{
                    print(error)
                }
    }
    func deleteSavedCollection(collectionPhoto:savedPhoto){
                let entityName="MyCollectionData"

                // Anfrage stellen
                let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
         do{
             let results = try context!.fetch(request)
             guard results.count > 0 else {
                 return
             }
             for collectionData in results as! [NSManagedObject]{
               
                 if(collectionData.value(forKey: "sneakerName") as! String == collectionPhoto.sneakerName ){
                     context!.delete(collectionData)
                 }
             }
            do{
                try context!.save()
                print("Gelöschtes Collection Element")
            }catch{
                print(error)
            }
         }catch{
             print(error)
         }
    }
    func saveCollectionPhoto(collectionPhoto:savedPhoto){
        let entityName="MyCollectionData" // Tabellenname im Datenmodell
       // Neuen Datensatz anlegen
        guard let newEntity = NSEntityDescription.entity(forEntityName: entityName, in: context!)else{
            return
        }
        let collectionData = NSManagedObject(entity:newEntity,insertInto: context)
        
         let sneakerName = collectionPhoto.sneakerName
        let picture = collectionPhoto.picture.jpegData(compressionQuality: 1)
      
        
         collectionData.setValue(sneakerName, forKey: "sneakerName")
         collectionData.setValue(picture, forKey: "picture")
    
         
         do{
            try context!.save()
            print("Gespeichert: ",collectionData)
         }catch{
             print(error)
         }
    }
    func loadSavedBlogposts() ->[BlogPost]{
        var savedBlogpost :[BlogPost]=[]
        let entityName="BlogpostData"
        
        // Anfrage stellen
        let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let results = try context!.fetch(request)
            
            
            for blogpo in results as! [NSManagedObject]{
               let title=blogpo.value(forKey: "title") as! String
               let text = blogpo.value(forKey: "text") as! String
               let category = blogpo.value(forKey: "category") as! String
               let contentPictures = blogpo.value(forKey: "contentPictures") as! [String]
               let contentVideo = blogpo.value(forKey: "contentVideo") as! String
               let cover = blogpo.value(forKey: "cover") as! String
               let shareLink = blogpo.value(forKey:"shareLink") as! String
               let blogpost=BlogPost(title: title, cover: cover, category: category, description: text, contentPictures: contentPictures, shareLink: shareLink, contentVideo: contentVideo)
               savedBlogpost.append(blogpost)
               
            }
            print ("Geladen: '\(results.count)' Blogpost Ergebnisse")
        }
        
        catch{
            print(error)
        }
        return savedBlogpost
       }
    
    func loadSavedSneakers()->[Sneaker]{
        var savedSneaker :[Sneaker]=[]
        let entityName="SneakerData"
        
        let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let results = try context!.fetch(request)
            
            
               for snkr in results as! [NSManagedObject]{
                let title=snkr.value(forKey: "title") as! String
                let text = snkr.value(forKey: "text") as! String
                let retailPrice = snkr.value(forKey:"retailPrice") as! String
                let imageURL = snkr.value(forKey: "imageURL") as! String
                let imageArray = snkr.value(forKey: "imgArray") as! [String]
                let priceSpan = snkr.value(forKey: "priceSpan") as! String
                let releaseDate = snkr.value(forKey: "releaseDate") as! String
                let position = snkr.value(forKey:"position") as! String
                let brand = snkr.value(forKey:"brand") as! String
                let sneaker = Sneaker(title: title, imageURL: imageURL, retailPrice: retailPrice, priceSpan: priceSpan, releaseDate: releaseDate, imgArray: imageArray, brand: brand, description: text, position: position)
                         savedSneaker.append(sneaker)
                         
                      }
            print ("Geladen: '\(results.count)' Sneaker Ergebnisse")
        }
        
        catch{
            print(error)
        }
        return savedSneaker
    }
    
    func saveBlogpost(blogPost:BlogPost?){
               let entityName="BlogpostData" // Tabellenname im Datenmodell
              // Neuen Datensatz anlegen
        guard let newEntity = NSEntityDescription.entity(forEntityName: entityName, in: context!)else{
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
                    try context!.save()
                      print("Gespeichert :",savedBlogpost)
                }catch{
                    print(error)
                }
    }
    
    func deleteBlogpost(blogPost:BlogPost?){
               let entityName="BlogpostData"

               // Anfrage stellen
               let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let results = try context!.fetch(request)
            guard results.count > 0 else {
                return
            }
            for blogpo in results as! [NSManagedObject]{
              
                if(blogpo.value(forKey: "title") as! String == blogPost?.title ){
                    context!.delete(blogpo)
                }
            }
            do{
                try context!.save()
                print("Blogpost Element Gelöscht")
         }catch{
             print(error)
         }
        }catch{
            print(error)
        }
    }
    
    
    func checkSavedBlogpost(blogPost:BlogPost?) -> Bool{
               let entityName="BlogpostData"

               // Anfrage stellen
               let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let results = try context!.fetch(request)
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
                 let entityName="SneakerData"

                 // Anfrage stellen
                 let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
          do{
            let results = try context!.fetch(request)
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

        let entityName="SneakerData"

        // Anfrage stellen
        let request=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
         do{
            let results = try context!.fetch(request)
             guard results.count > 0 else {
                 return
             }
             for snkr in results as! [NSManagedObject]{
                 if(snkr.value(forKey: "title") as! String == sneaker?.title ){
                    context!.delete(snkr)
                 }
             }
            do{
                try context!.save()
                print("Gelöschtes Sneaker Element")
           }catch{
               print(error)
           }
         }catch{
             print(error)
         }
     }
    
    
    
    func saveSneaker(sneaker:Sneaker?){
        let entityName="SneakerData" // Tabellenname im Datenmodell
       // Neuen Datensatz anlegen
        guard let newEntity = NSEntityDescription.entity(forEntityName: entityName, in: context!)else{
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
                    try context!.save()
                       print("Gespeichert: ",savedSneaker)
          //             context.delete(savedSneaker)
          //             print("Gelöscht")
                 }catch{
                     print(error)
                 }
    }
}
