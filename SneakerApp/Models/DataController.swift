////
////  SneakerModel.swift
////  SneakerApp
////
////  Created by Dung  on 17.12.19.
////  Copyright © 2019 Dung. All rights reserved.
////
//
//import Foundation
//import CoreData
//
//class DataController{
//   let persistentContainer = NSPersistentContainer(name: "LibraryDataModel")
//
//    var context: NSManagedObjectContext {
//        return self.persistentContainer.viewContext
//    }
//
//    func initalizeStack() {
//           // 2.
//           self.persistentContainer.loadPersistentStores { description, error in
//               // 3.
//               if let error = error {
//                   print("could not load store \(error.localizedDescription)")
//                   return
//               }
//
//               print("store loaded")
//           }
//       }
//
//    func createSneaker(name:String,brand:String,date:String){
//        let sneaker = SneakerData(context: context)
//        sneaker.name = name
//        sneaker.brand = brand
//        sneaker.date = date
//        self.context.insert(sneaker)
//        do{
//        try self.context.save()
//
//        }catch{
//            print("ERRROROR")
//        }
//    }
//
//    func fetchUsers() throws -> [SneakerData] {
//        let sneakers = try self.context.fetch(SneakerData.fetchRequest() as NSFetchRequest<SneakerData>)
//        return sneakers
//    }
//}
