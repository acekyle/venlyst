//
//  MapViewController.swift
//  BarberClub
//
//  Created by Aaron Anderson on 8/28/16.
//  Copyright © 2016 Aaron Anderson. All rights reserved.
//

import UIKit
import MapKit
import Social
import CoreData

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellId = "mapVenueCell"
    let annotationIdentifier = "AnnotationIdentifier"
    var venues = [Venue]()
    var selectedVenue = [Venue]()
    let coreHelper = CoreStack()
    let funcHelper = HelperFunctions()
    
    open var plots = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.5) {
            self.venuePeekCollectionView.isHidden = true
        }
    }

//    func makeCall(phone: String) {
//        let number = phone.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
//        let phoneUrl = "tel://\(number)"
//        let url:NSURL = NSURL(string: phoneUrl)!
//        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
//    }

//    func getDirections(){
//        let shopCoorsUrl = "https://maps.apple.com/?daddr=6238 Hwy 6, Missouri City, TX 77459"
//        
//        if let url = NSURL(string: shopCoorsUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!){
//            
//            UIApplication.sharedApplication().openURL(url)
//        }
//    }
//    
  
    
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(venueMapView)
        venueMapView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        configureCollectionView()
        venues = coreHelper.fetchAllVenueData()!
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.venueMapView.showsUserLocation = true
        self.venuePeekCollectionView.isHidden = true
        
    }
    
    lazy var venueMapView: MKMapView = {
        let m = MKMapView()
        m.showsUserLocation = true
        m.delegate = self
        m.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        return m
    }()
    
    lazy var venuePeekCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(MapPopupCell.self, forCellWithReuseIdentifier: self.cellId)
        return collectionView

    }()
    
    func fetchVenueByName(name: String) {
        
        let venueData: NSFetchRequest<Venue> = Venue.fetchRequest()
        venueData.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [NSPredicate(format: "name = %@", name)])
        do{
            selectedVenue = try managedObjectContext.fetch(venueData)
        }catch{ print("Could not load data from database") }
    }
    
    func configureCollectionView() {

        view.addSubview(venuePeekCollectionView)
        view.bringSubview(toFront: venuePeekCollectionView)
        venuePeekCollectionView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: view.frame.height / 2)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation : CLLocation = locations[0]
        let usLat = userLocation.coordinate.latitude
        let usLon = userLocation.coordinate.longitude
        
        let downtownH = CLLocationCoordinate2D(latitude: 29.7630166, longitude: -95.3653127)
        
        _ = CLLocationCoordinate2D(latitude: usLat, longitude: usLon)
        let region = MKCoordinateRegion(center: downtownH, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        self.venueMapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
      
    }
 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Error" + error.localizedDescription)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MapPopupCell
        
        if selectedVenue.isEmpty{} else {
            
            cell.datasourceItem = selectedVenue[0]
            
        }
        return cell
        
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }else {
            let button = UIButton(type: .detailDisclosure)
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = button
        }
        
        if let annotationView = annotationView {

            annotationView.image = #imageLiteral(resourceName: "LocationIcon")
        }
        
        return annotationView
    }

 
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        fetchVenueByName(name: (view.annotation?.title!)!)
        
        venuePeekCollectionView.isHidden = false
        venuePeekCollectionView.reloadData()
        
    }
    
}
