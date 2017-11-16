//
//  CoreHelper.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/26/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import CoreData


class CoreStack {
    
    static let coreData = CoreStack()
    
    func clearUserData(){
        let userData: NSFetchRequest<User> = User.fetchRequest()
        var currentUser = [User]()
        do{
            currentUser = try managedObjectContext.fetch(userData)
            for user in currentUser {managedObjectContext.delete(user)}
            try managedObjectContext.save()
            
        }catch{ print("Could not load data from database") }
    }
    
    func clearVenueData(currentVenues: [Venue]) {
        let venueData: NSFetchRequest<Venue> = Venue.fetchRequest()
        var venues = currentVenues
        do{
            venues = try managedObjectContext.fetch(venueData)
            for venue in venues {managedObjectContext.delete(venue)}
            try managedObjectContext.save()
            
        }catch{ print("Could not load data from database") }
    }
    
    func fetchUserData() -> [User]? {
        
        let userData: NSFetchRequest<User> = User.fetchRequest()
        var currentUser = [User]()
        do{
            currentUser = try managedObjectContext.fetch(userData)
            
        }catch{ print("Could not load data from database") }
        
        return currentUser
    }
    
    func fetchAllVenueData() -> [Venue]? {
        let venueData: NSFetchRequest<Venue> = Venue.fetchRequest()
        var venues = [Venue]()
        do{
            venues = try managedObjectContext.fetch(venueData)
            
        }catch{ print("Could not load data from database") }
        
        return venues
    }
    
    func fetchAllVendorData() -> [Vendor]? {
        let vendorData: NSFetchRequest<Vendor> = Vendor.fetchRequest()
        var vendors = [Vendor]()
        do{
            vendors = try managedObjectContext.fetch(vendorData)
            
        }catch{ print("Could not load data from database") }
        return vendors
    }
    
    func fetchUserDataById(id: String) -> [User]? {
        
        let userData: NSFetchRequest<User> = User.fetchRequest()
        userData.predicate = NSPredicate(format: "id = %@", id)
        var currentUser = [User]()
        
        do{
            currentUser = try managedObjectContext.fetch(userData)
            
        }catch{ print("Could not load data from database") }
        
        return currentUser
        
    }
    
    func fetchVenueDataByIds(ids: [String]) -> [Venue]? {
        let venueData: NSFetchRequest<Venue> = Venue.fetchRequest()
        var venues = [Venue]()
        for id in ids {
            venueData.predicate = NSPredicate(format: "id = %@", id)
            do{
                venues += try managedObjectContext.fetch(venueData)
                
            }catch{ print("Could not load data from database") }
        }
        
        return venues
    }
    
    func fetchVenueDataById(id: String) -> [Venue]? {
        let venueData: NSFetchRequest<Venue> = Venue.fetchRequest()
        venueData.predicate = NSPredicate(format: "id = %@", id)
        var venues = [Venue]()
        do{
            venues = try managedObjectContext.fetch(venueData)
            
        }catch{ print("Could not load data from database") }
        
        return venues
    }
    
    func fetchVendorDataById(id: String) -> [Vendor]? {
        let vendorData: NSFetchRequest<Vendor> = Vendor.fetchRequest()
        var vendors = [Vendor]()
        vendorData.predicate = NSPredicate(format: "id = %@", id)
        do{
            vendors = try managedObjectContext.fetch(vendorData)
            
        }catch{ print("Could not load data from database") }
        
        return vendors
    }
    
    func fetchVendorsDataByIds(ids: [String]) -> [Vendor]? {
        let vendorData: NSFetchRequest<Vendor> = Vendor.fetchRequest()
        var vendors = [Vendor]()
        for id in ids {
            vendorData.predicate = NSPredicate(format: "id = %@", id)
            do{
                vendors += try managedObjectContext.fetch(vendorData)
                
            }catch{ print("Could not load data from database") }
        }
        
        return vendors
    }
    
    func saveUserToCoreData(userArray: [UserDecodable]) {
        
        for user in userArray {
            
            let newUser = User(context: managedObjectContext)
            
            newUser.name = user.firstName
            newUser.recentVendors = user.recentVendors as NSObject
            newUser.recentVenues = user.recentVenues as NSObject
            newUser.favorites = user.favorites as NSObject
            newUser.city = user.address
//            newUser.state = user.state
            newUser.profilePic = user.image
            newUser.id = user.id
            newUser.email = user.email
            newUser.phone = user.phone
//            newUser.zipcode = user.zipcode
            newUser.subscribedDate = user.date
            
            do{
                try managedObjectContext.save()
            }catch{
                print("There was an error \(error.localizedDescription)")
            }
        }
    }
    
    func saveVenuesInCoreData(venueArray: [VenueDecodable]) {
//        for venue in venueArray {
//            let newVenue = Venue(context: managedObjectContext)
//            newVenue.name = venue.name
//            newVenue.city = venue.city
//            newVenue.state = venue.state
//            newVenue.street = venue.street
//            newVenue.zipcode = venue.zipcode
//            newVenue.venueDescription = venue.venueDescription
//            newVenue.venueThumbPic = venue.venueThumbPic
//            newVenue.longitude = venue.longitude
//            newVenue.latitude = venue.latitude
//            newVenue.videoLink = venue.videoLink
//            newVenue.matterportLink = venue.matterportLink
//            newVenue.active = venue.active
//            newVenue.activeDate = venue.activeDate
//            newVenue.occupancy = venue.occupancy
//            newVenue.lookFeel = venue.lookFeel
//            newVenue.sqFoot = venue.sqFoot
//            newVenue.venueContact = venue.venueContact
//            newVenue.timezone = venue.timezone
//            newVenue.av = venue.av
//            newVenue.bar = venue.bar
//            newVenue.bc = venue.bc
//            newVenue.food = venue.food
//            newVenue.pf = venue.pf
//            newVenue.pool = venue.pool
//            newVenue.roof = venue.roof
//            newVenue.smoking = venue.smoking
//            newVenue.strtPark = venue.strtPark
//            newVenue.tabl = venue.tabl
//            newVenue.valet = venue.valet
//            newVenue.wifi = venue.wifi
//            newVenue.fbLink = venue.fbLink
//            newVenue.twitLink = venue.twitLink
//            newVenue.instaLink = venue.instaLink
//            newVenue.venueType = venue.venueType
//            newVenue.venueDetailedPic = venue.venueDetailedPic
//            newVenue.id = venue.id!
//            
//            
//            do{
//                try managedObjectContext.save()
//                
//            }catch{
//                print("There was an error \(error.localizedDescription)")
//            }
//            
//            
//        }
    }

    func updateUserFavorites(value: Any) {
        
        let userData: NSFetchRequest<User> = User.fetchRequest()
        do{
            let user = try managedObjectContext.fetch(userData)
            let updateUser = user[0] as NSManagedObject
            updateUser.setValue(value, forKey: "favorites")
            
            do {
                try managedObjectContext.save()
            } catch {
                print("Could not save Users favortites to database")
            }
            
        }catch{ print("Could not load data from database") }
        
    }
    
    func updateUserRecentVenues(value: Any) {
        
        let userData: NSFetchRequest<User> = User.fetchRequest()
        do{
            let user = try managedObjectContext.fetch(userData)
            let updateUser = user[0] as NSManagedObject
            updateUser.setValue(value, forKey: "recentVenues")
            
            do {
                try managedObjectContext.save()
            } catch {
                print("Could not save Users Recent venues to database")
            }
            
        }catch{ print("Could not load data from database") }
        
    }
    
    func updateUserRecentVendors(value: Any) {
        
        let userData: NSFetchRequest<User> = User.fetchRequest()
        do{
            let user = try managedObjectContext.fetch(userData)
            let updateUser = user[0] as NSManagedObject
            updateUser.setValue(value, forKey: "recentVendors")
            
            do {
                try managedObjectContext.save()
            } catch {
                print("Could not save Users Recent Vendors to database")
            }
            
        }catch{ print("Could not load data from database") }
        
    }
    
    
}







