//
//  User.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/10/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit
import LBTAComponents
import SwiftyJSON
import TRON

struct UserDecodable: JSONDecodable{
    
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let mobile: String
    let address: String
    let description: String
    let image: String
    let facebook: String
    var twitter: String
    let date: String
    var recentVenues: [String]
    var recentVendors: [String]
    var favorites: [String]
    
    init(json: JSON) {
        
        self.id = json["id"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.email = json["email"].stringValue
        self.phone = json["phone_no"].stringValue
        self.mobile = json["mobile_no"].stringValue
        self.address = json["address"].stringValue
        self.description = json["description"].stringValue
        self.facebook = json["facebook"].stringValue
        self.twitter = json["twitter"].stringValue
        self.image = json["image"].stringValue
        self.date = json["date"].stringValue
        
        if (json["recent_venues"].arrayObject == nil) {
           self.recentVenues = []
        }else{
            self.recentVenues = json["recent_venues"].arrayObject as! [String]
        }
        
        if (json["recent_vendors"].arrayObject == nil) {
            self.recentVendors = []
        }else{
            self.recentVendors = json["recent_vendors"].arrayObject as! [String]
        }
        
        if (json["favorites"].arrayObject == nil) {
            self.favorites = []
        }else{
            self.favorites = json["favorites"].arrayObject as! [String]
        }
    }
}

//class FavoriteCategory: NSObject {
//    var name: String?
//    var venueDescription: String?
//    var lastVenueImage: String?
//}

class RecentCategory: NSObject {
    var name: String?
    var recentVenues: [Venue]?
    var recentVendors: [Vendor]?

}
    


