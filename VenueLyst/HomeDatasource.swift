
//
//  HomeDatasource.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/11/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDatasource: Datasource, JSONDecodable {
    
    let users: [UserDecodable]
    
    required init(json: JSON) {
        
        var users = [UserDecodable]()
        
        let jsonUsersArray = json["items"].array
  
        if jsonUsersArray != nil {
            if !(jsonUsersArray?.isEmpty)! {
                if !(jsonUsersArray?.first?.isEmpty)! {
                        for u in jsonUsersArray!{
                            let user = UserDecodable(json: u)
                            users.append(user)
                        }
                    self.users = users
                }else{                    
                    self.users = users
                }
            }else{
                self.users = users
            }
        }else{
            self.users = users
        }
    }
    
    
    
}

















