//
//  StackPop.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/29/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import Foundation
import MapKit


class HelperFunctions {
    
    let userDefaults = UserDefaults.standard
    
    // MARK: -- MAP HELPER FUNCTIONS --
    
    func centerMapOnLocation(location: CLLocation, mapView: MKMapView, regionRadius: Double) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func plotVenues(venues: [Venue]=[]) -> [MKAnnotation] {
        
        var pointsToPlot: [MKPointAnnotation] = []
        
        if venues.isEmpty {
            print("No venues to plot on map")
        }else{
            
            for venue in venues {
                
                let name = venue.name
                let locationName = "\(venue.city ?? "")"
                let lat = Double(venue.latitude!)
                let long = Double(venue.longitude!)
                let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat!) , longitude: CLLocationDegrees(long!))
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = name
                annotation.subtitle = locationName
                
                pointsToPlot.append(annotation)
                
            }
        }
        
        if pointsToPlot.count > 1 {
            userDefaults.set(true, forKey: "didPlot")
        }
        
        return pointsToPlot
    }
    
    
    
    
}





class Node<T> {
    let value: T
    var next: Node?
    init(value: T) {
        self.value = value
    }
}

class Stack<T> {
    
    var top: Node<T>?
    
    func push(_ value: T) {
        let oldTop = top
        top = Node(value: value)
        top?.next = oldTop
    }
    
    func pop() -> T? {
        let currentTop = top
        top = top?.next
        return currentTop?.value
    }
    
    func peek() -> T? {
        return top?.value
    }
    
}
