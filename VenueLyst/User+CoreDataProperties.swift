//
//  User+CoreDataProperties.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/16/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var recentVendors: NSObject?
    @NSManaged public var recentVenues: NSObject?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var profilePic: String?
    @NSManaged public var id: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var subscribedDate: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var favorites: NSObject?

}
