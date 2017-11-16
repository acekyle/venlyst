//
//  Vendor+CoreDataProperties.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/10/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import Foundation
import CoreData


extension Vendor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vendor> {
        return NSFetchRequest<Vendor>(entityName: "Vendor")
    }

    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var specialization: String?
    @NSManaged public var experience: String?
    @NSManaged public var vendorType: String?
    @NSManaged public var vendorDescription: String?
    @NSManaged public var vendorRate: String?
    @NSManaged public var vendorContact: String?
    @NSManaged public var fbLink: String?
    @NSManaged public var twitLink: String?
    @NSManaged public var instaLink: String?
    @NSManaged public var vendorDetailedPic: NSObject?
    @NSManaged public var id: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var userFullName: String?
    @NSManaged public var isFeatured: String?
    @NSManaged public var createdOn: String?

}
