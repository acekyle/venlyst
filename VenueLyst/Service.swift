//
//  Service.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/6/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

let userHelper = CoreUserStack()

struct Service {
    
    static let sharedInstance = Service()
    
    let tron = TRON(baseURL: "http://52.14.88.26:8323")
    let userUrl = TRON(baseURL: userHelper.getApi()!)
    let venUrl = TRON(baseURL: "http://venuelyst2.mohsinforshopify.com/api")
    
    func fetchSearchControllerData(completion: @escaping (SearchDatasource) -> ()){
        
        let request: APIRequest<SearchDatasource, JsonError> = venUrl.request("/venues_list_api.php")
        
        request.perform(withSuccess: { (Search) in
                        
            completion(Search)
            
        }) { (error) in print("Json failed for some reason")}
        
    }
    
    func fetchVendorsControllerData(completion: @escaping (VendorDatasource) -> ()){
        
        let request: APIRequest<VendorDatasource, JsonError> = venUrl.request("/vendors_list_api.php")
        
        request.perform(withSuccess: { (Vendor) in
                        
            completion(Vendor)
            
        }) { (error) in print("Json failed for some reason")}
        
    }
    
    func fetchHomeControllerData(email: String, password: String, completion: @escaping (HomeDatasource) -> ()){

        let url = "/api/api.php?format=json&user=\(email)&pass=\(password)"
        let request: APIRequest<HomeDatasource, JsonError> = userUrl.request(url)
        
        request.perform(withSuccess: { (Home) in
            
            completion(Home)
            
        }) { (error) in print("Json failed for some reason")}
        
    }

    class JsonError: JSONDecodable {
        
        required init(json: JSON) {
            print("Json Error")
            
        }
    }
    
    
}

