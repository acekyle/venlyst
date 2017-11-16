//
//  Venue+CoreDataProperties.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/10/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import Foundation
import CoreData


extension Venue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }

    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var venueDescription: String?
    @NSManaged public var longitude: String?
    @NSManaged public var latitude: String?
    @NSManaged public var matterportLink: String?
    @NSManaged public var occupancy: String?
    @NSManaged public var sqFoot: String?
    @NSManaged public var venueContact: String?
    @NSManaged public var fbLink: String?
    @NSManaged public var twitLink: String?
    @NSManaged public var instaLink: String?
    @NSManaged public var venueType: String?
    @NSManaged public var venueDetailedPic: NSObject?
    @NSManaged public var id: String?
    @NSManaged public var emailTwo: String?
    @NSManaged public var isFeatured: String?
    @NSManaged public var userFullName: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var createdOn: String?
    @NSManaged public var venueRules: String?
    
    @NSManaged public var avEquipment: String?
    @NSManaged public var beach: String?
    @NSManaged public var breakOut: String?
    @NSManaged public var businessCenter: String?
    @NSManaged public var coatCheck: String?
    @NSManaged public var greatView: String?
    @NSManaged public var handicapAccessible: String?
    @NSManaged public var indoor: String?
    @NSManaged public var mediaRoom: String?
    @NSManaged public var non_smoking: String?
    @NSManaged public var outdoor: String?
    @NSManaged public var overnightRooms: String?
    @NSManaged public var pet_friendly: String?
    @NSManaged public var pool: String?
    @NSManaged public var rooftop: String?
    @NSManaged public var rooms_available: String?
    @NSManaged public var smoking: String?
    @NSManaged public var spa: String?
    @NSManaged public var streetParkingTheater: String?
    @NSManaged public var valet: String?
    @NSManaged public var wifi: String?
    
    @NSManaged public var foodInHouse: String?
    @NSManaged public var foodPreferred: String?
    @NSManaged public var foodOutside: String?
    
    @NSManaged public var bevInHouse: String?
    @NSManaged public var bevOutside: String?
    @NSManaged public var bevPreferred: String?
    @NSManaged public var bevNotAllowed: String?
    
    @NSManaged public var friSatPrice: String?
    @NSManaged public var friSatBuyoutPrice: String?
    @NSManaged public var sunThursPrice: String?
    @NSManaged public var sunThursBuyoutPrice: String?
    @NSManaged public var weddingsPrice: String?
    
    @NSManaged public var monFrom: String?
    @NSManaged public var monTo: String?
    @NSManaged public var monClosed: String?
    @NSManaged public var tueFrom: String?
    @NSManaged public var tueTo: String?
    @NSManaged public var tueClosed: String?
    @NSManaged public var wedFrom: String?
    @NSManaged public var wedTo: String?
    @NSManaged public var wedClosed: String?
    @NSManaged public var thuFrom: String?
    @NSManaged public var thuTo: String?
    @NSManaged public var thuClosed: String?
    @NSManaged public var friFrom: String?
    @NSManaged public var friTo: String?
    @NSManaged public var friClosed: String?
    @NSManaged public var satFrom: String?
    @NSManaged public var satTo: String?
    @NSManaged public var satClosed: String?
    @NSManaged public var sunFrom: String?
    @NSManaged public var sunTo: String?
    @NSManaged public var sunClosed: String?
    

}

















