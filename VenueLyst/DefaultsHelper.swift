//
//  DefaultsHelper.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 10/13/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit

class CoreUserStack {
    
    static let userStack = CoreUserStack()
    let defaults = UserDefaults.standard
    
    func setEmail(_ email: String) {
        defaults.set(email, forKey: "email")
        synchronizeDefaults()
    }
    
    func getEmail() -> String {
        return defaults.string(forKey: "email")!
    }
    
  
    func setKey(_ key: String) {
        defaults.set(key, forKey: "key")
        synchronizeDefaults()
    }
    
    func getKey() -> String? {
        return defaults.string(forKey: "key")!
    }
    
    func setId(_ id: String) {
        defaults.set(id, forKey: "id")
        synchronizeDefaults()
    }
    
    func getId() -> String? {
        return defaults.string(forKey: "id")!
    }
    
    func setApi(_ email: String, pass: String) {
        let userApi = "http://venuelyst2.mohsinforshopify.com/api/api.php?format=json&user=\(email)&pass=\(pass)"
        defaults.set(userApi, forKey: "api")
        synchronizeDefaults()
        
        print("Api set as: ", getApi()!)
    }
    
    func getApi() -> String? {
        return defaults.string(forKey: "api")!
    }
    
    fileprivate func synchronizeDefaults() {
        UserDefaults.standard.synchronize()
    }
    
    func clearData() {
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "id")
        defaults.removeObject(forKey: "key")
        
        synchronizeDefaults()
    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.string(forKey: "api") != nil
    }
}
