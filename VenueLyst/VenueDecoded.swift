//
//  Venue.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/6/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit
import LBTAComponents
import SwiftyJSON
import TRON

struct VenueDecodable: JSONDecodable {
    
    let id: String?
    let name: String?
    let city: String?
    let venueDescription: String?
    let fbLink: String?
    let twitLink: String?
    let instaLink: String?
    let venueType: String?
    let venueDetailedPic: String?
    let occupancy: String?
    let sqFoot: String?
    let venueContact: String?
    let longitude: String?
    let latitude: String?
    let matterportLink: String?
    let emailTwo: String?
    let isFeatured: String?
    let createdOn: String?
    let userFullName: String?
    let userEmail: String?
    let venueRules: String?
 
    let avEquipment: String
    let beach: String
    let breakOut: String
    let businessCenter: String
    let coatCheck: String
    let greatView: String
    let handicapAccessible: String
    let indoor: String
    let mediaRoom: String
    let non_smoking: String
    let outdoor: String
    let overnightRooms: String
    let pet_friendly: String
    let pool: String
    let rooftop: String
    let rooms_available: String
    let smoking: String
    let spa: String
    let streetParkingTheater: String
    let valet: String
    let wifi: String
    
    let foodInHouse: String
    let foodPreferred: String
    let foodOutside: String
    
    let bevInHouse: String
    let bevPreferred: String
    let bevOutside: String
    let bevNotAllowed: String
    
    let friSatPrice: String
    let friSatBuyoutPrice: String
    let sunThursPrice: String
    let sunThursBuyoutPrice: String
    let weddingsPrice: String
    
    let monFrom: String
    let monTo: String
    let monClosed: String
    let tueFrom: String
    let tueTo: String
    let tueClosed: String
    let wedFrom: String
    let wedTo: String
    let wedClosed: String
    let thuFrom: String
    let thuTo: String
    let thuClosed: String
    let friFrom: String
    let friTo: String
    let friClosed: String
    let satFrom: String
    let satTo: String
    let satClosed: String
    let sunFrom: String
    let sunTo: String
    let sunClosed: String
    
    init(json: JSON) {
        
        self.id = json["id"].stringValue
        self.name = json["venue_name"].stringValue
        self.city = json["address"].stringValue
        self.venueDescription = json["description"].stringValue
        self.venueContact = json["phone_no"].stringValue
        self.longitude = json["location_longitude"].stringValue
        self.latitude = json["location_latitude"].stringValue
        self.matterportLink = json["three_d_video_code"].stringValue
        self.occupancy = json["guest_capacity"].stringValue
        self.sqFoot = json["square_feet"].stringValue
        self.fbLink = json["facebook_url"].stringValue
        self.twitLink = json["twitter_url"].stringValue
        self.instaLink = json["instagram_url"].stringValue
        self.venueType = json["venue_type_name"].stringValue
        self.venueDetailedPic = json["images"].stringValue
        self.emailTwo = json["email2"].stringValue
        self.isFeatured = json["is_featured"].stringValue
        self.createdOn = json["created_on"].stringValue
        self.userFullName = json["user_full_name"].stringValue
        self.userEmail = json["user_email"].stringValue
        self.venueRules = json["venue_rules"].stringValue
        
        self.avEquipment = json["amenities"]["av_equipment"].stringValue
        self.beach = json["amenities"]["beachfront"].stringValue
        self.breakOut = json["amenities"]["break_out_rooms"].stringValue
        self.businessCenter = json["amenities"]["business_center"].stringValue
        self.coatCheck = json["amenities"]["coat_check"].stringValue
        self.greatView = json["amenities"]["great_views"].stringValue
        self.handicapAccessible = json["amenities"]["handicap_accessible"].stringValue
        self.indoor = json["amenities"]["indoor"].stringValue
        self.mediaRoom = json["amenities"]["media_room"].stringValue
        self.non_smoking = json["amenities"]["non_smoking"].stringValue
        self.outdoor = json["amenities"]["outdoor"].stringValue
        self.overnightRooms = json["amenities"]["overnight_rooms"].stringValue
        self.pet_friendly = json["amenities"]["pet_friendly"].stringValue
        self.pool = json["amenities"]["pool"].stringValue
        self.rooftop = json["amenities"]["rooftop"].stringValue
        self.rooms_available = json["amenities"]["rooms_available"].stringValue
        self.smoking = json["amenities"]["smoking"].stringValue
        self.spa = json["amenities"]["spa"].stringValue
        self.streetParkingTheater = json["amenities"]["street_parking_theater"].stringValue
        self.valet = json["amenities"]["valet_parking"].stringValue
        self.wifi = json["amenities"]["wifi"].stringValue

        self.foodInHouse = json["food"]["in_house_only"].stringValue
        self.foodPreferred = json["food"]["preferred_caterers"].stringValue
        self.foodOutside = json["food"]["outside_catering_allowed"].stringValue
        
        self.bevInHouse = json["beverages"]["in_house_only"].stringValue
        self.bevOutside = json["beverages"]["byob_allowed"].stringValue
        self.bevPreferred = json["beverages"]["preferred_suppliers_only"].stringValue
        self.bevNotAllowed = json["beverages"]["no_alcohol_allowed"].stringValue
        
        self.friSatPrice = json["start_prices"]["fri_sat_price"].stringValue
        self.friSatBuyoutPrice = json["start_prices"]["fri_sat_buyout_price"].stringValue
        self.sunThursPrice = json["start_prices"]["sun_thurs_price"].stringValue
        self.sunThursBuyoutPrice = json["start_prices"]["sun_thurs_buyout_price"].stringValue
        self.weddingsPrice = json["start_prices"]["weddings_price"].stringValue
        
        self.monFrom = json["business_hours"]["mon_from"].stringValue
        self.monTo = json["business_hours"]["mon_to"].stringValue
        self.monClosed = json["business_hours"]["mon_closed"].stringValue
        self.tueFrom = json["business_hours"]["tue_from"].stringValue
        self.tueTo = json["business_hours"]["tue_to"].stringValue
        self.tueClosed = json["business_hours"]["tue_closed"].stringValue
        self.wedFrom = json["business_hours"]["wed_from"].stringValue
        self.wedTo = json["business_hours"]["wed_to"].stringValue
        self.wedClosed = json["business_hours"]["wed_closed"].stringValue
        self.thuFrom = json["business_hours"]["thu_from"].stringValue
        self.thuTo = json["business_hours"]["thu_to"].stringValue
        self.thuClosed = json["business_hours"]["thu_closed"].stringValue
        self.friFrom = json["business_hours"]["fri_from"].stringValue
        self.friTo = json["business_hours"]["fri_to"].stringValue
        self.friClosed = json["business_hours"]["fri_closed"].stringValue
        self.satFrom = json["business_hours"]["sat_from"].stringValue
        self.satTo = json["business_hours"]["sat_to"].stringValue
        self.satClosed = json["business_hours"]["sat_closed"].stringValue
        self.sunFrom = json["business_hours"]["sun_from"].stringValue
        self.sunTo = json["business_hours"]["sun_to"].stringValue
        self.sunClosed = json["business_hours"]["sun_closed"].stringValue
        
        
        print("Long, Lat from the internet", self.longitude, self.latitude)
        
        
    }
}


struct VendorDecodable: JSONDecodable {
    
    let id: String?
    let name: String?
    let city: String?
    let specialization: String?
    let experience: String?
    let vendorType: String?
    let vendorDescription: String?
    let vendorRate: String?
    let vendorContact: String?
    let fbLink: String?
    let twitLink: String?
    let instaLink: String?
    let vendorDetailedPic: String?
    let userEmail: String?
    let userFullName: String?
    let isFeatured: String?
    let createdOn: String?
    
    init(json: JSON) {
        
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.vendorType = json["vendor_type"].stringValue
        self.city = json["city_name"].stringValue
        self.vendorDescription = json["description"].stringValue
        self.vendorContact = json["phone"].stringValue
        self.experience = json["experience"].stringValue
        self.specialization = json["specializes_in"].stringValue
        self.vendorRate = json["hourly_rate"].stringValue
        self.fbLink = json["facebook_url"].stringValue
        self.twitLink = json["twitter_url"].stringValue
        self.instaLink = json["instagram_url"].stringValue
        self.vendorDetailedPic = json["images"].stringValue
        self.userEmail = json["user_email"].stringValue
        self.userFullName = json["user_full_name"].stringValue
        self.isFeatured = json["is_featured"].stringValue
        self.createdOn = json["created_on"].stringValue
        
    }
}








