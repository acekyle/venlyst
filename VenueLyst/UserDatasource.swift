//
//  UserDatasource.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/10/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

//import LBTAComponents
//import TRON
//import SwiftyJSON
//
//class UserDatasource: Datasource, JSONDecodable {
//    
//    let users: [UserDecodable]
//    
//    required init(json: JSON) {
//        
//        var users = [UserDecodable]()
//        let jsonUsersArray = json["Users"].array
//                
//        for u in jsonUsersArray!{
//            
//            let user = UserDecodable(json: u)
//            users.append(user)
//        }
//        
//        self.users = users
//        
//    }
//    
//    func getUserId() -> String {
//        return ""
//    }
//    
//}
