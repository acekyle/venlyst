//
//  VendorDatasource.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/9/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class VendorDatasource: Datasource, JSONDecodable {
    
    let vendors: [VendorDecodable]
    
    required init(json: JSON) {
        
        var vendors = [VendorDecodable]()
        let jsonVendorArray = json["items"].array
        
        if jsonVendorArray != nil {
            if !(jsonVendorArray?.isEmpty)! {
                if !(jsonVendorArray?.first?.isEmpty)! {
                    for c in jsonVendorArray!{
                        let vendor = VendorDecodable(json: c)
                        vendors.append(vendor)
                    }
                    self.vendors = vendors
                }else{
                    self.vendors = vendors
                }
            }else{
                self.vendors = vendors
            }
        }else{
            self.vendors = vendors
        }
    }
    
    
}

