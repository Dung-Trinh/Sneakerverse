//
//  SneakerData+CoreDataProperties.swift
//  
//
//  Created by Dung  on 17.12.19.
//
//

import Foundation
import CoreData


extension SneakerData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SneakerData> {
        return NSFetchRequest<SneakerData>(entityName: "SneakerData")
    }

    @NSManaged public var name: String?
    @NSManaged public var brand: String?
    @NSManaged public var date: String?

}
