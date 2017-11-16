//
//  SearchDatasource.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/6/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class SearchDatasource: Datasource, JSONDecodable {
    
    let venues: [VenueDecodable]
    
    required init(json: JSON) {
        var venues = [VenueDecodable]()
        
        let jsonVenueArray = json["items"].array
        
        if jsonVenueArray != nil {
                if !(jsonVenueArray?.isEmpty)! {
                    if !(jsonVenueArray?.first?.isEmpty)! {
                      for v in jsonVenueArray!{
                        
                          let venue = VenueDecodable(json: v)
                          venues.append(venue)
                      }
                        self.venues = venues
                    }else{
                        self.venues = venues
                    }
                }else{
                    self.venues = venues
                }
            }else{
                self.venues = venues
            }
    }

    
    
}
