//
//  Item+CoreDataProperties.swift
//  Devote
//
//  Created by hazem smawy on 9/13/22.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var task: String?

}

extension Item : Identifiable {

}
