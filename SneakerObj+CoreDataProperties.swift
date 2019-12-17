//
//  SneakerObj+CoreDataProperties.swift
//  
//
//  Created by Dung  on 17.12.19.
//
//

import Foundation
import CoreData


extension SneakerObj {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SneakerObj> {
        return NSFetchRequest<SneakerObj>(entityName: "SneakerObj")
    }

    @NSManaged public var name: String?
    @NSManaged public var brand: String?
    @NSManaged public var date: String?

}
