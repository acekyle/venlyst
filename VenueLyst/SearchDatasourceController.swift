//
//  SearchDatasourceController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/6/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON
import MapKit
import CoreData

class SearchDatasourceController: DatasourceController, UISearchBarDelegate {
    
    let vendorCellId = "vendorCellId"
    let venueCellId = "venueCellId"
    var venues = [Venue]()
    var vendors = [Vendor]()
    var customSearchController: CustomSearchController!
    let coreHelper = CoreStack()
    let funcHelper =  HelperFunctions()
    private var plottedMap = false
    let userDefaults = UserDefaults.standard
    var currentUser = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavView()
        setupCollectionView()
        configureCustomSearchController()
        setupSegments()
        setupViews()
        
        //Dismiss Keyboard
        dismissKeyboardUsingTap(view: (getTopViewController()?.view)!)
        
        if let userCheck = coreHelper.fetchUserData() {
        
            if userCheck.count > 0 {
                
                currentUser = userCheck
                
            }else{
                
                Service.sharedInstance.fetchHomeControllerData (email: userHelper.getEmail(), password: userHelper.getKey()!){ (HomeDatasource) in
                    
                    self.coreHelper.clearUserData()
                    self.coreHelper.saveUserToCoreData(userArray: HomeDatasource.users)
                    
                }                
            }
            
        }
        
        
        if let venueCheck = coreHelper.fetchAllVenueData() {
            if venueCheck.count > 1 {
                
                venues = venueCheck
                
            }else{
                
                Service.sharedInstance.fetchSearchControllerData { (SearchDatasource) in
                    self.coreHelper.clearVenueData(currentVenues: self.venues)
                    self.saveVenuesInCoreData(venueArray: SearchDatasource.venues)
                    
                }
            }
        }
        
        
        if let vendorCheck = coreHelper.fetchAllVendorData() {
            if vendorCheck.count > 1 {

                vendors = vendorCheck
                
            }else{
                
                Service.sharedInstance.fetchVendorsControllerData { (VendorDatasource) in
                    self.clearVendorData()
                    self.saveVendorToCoreData(vendorArray: VendorDatasource.vendors)
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func fetchAllVenueData() {
        let venueData: NSFetchRequest<Venue> = Venue.fetchRequest()
        do{
            venues = try managedObjectContext.fetch(venueData)
            self.collectionView?.reloadData()
            
        }catch{ print("Could not load data from database") }
    }
    
    func saveVenuesInCoreData(venueArray: [VenueDecodable]) {
        for venue in venueArray {
            let newVenue = Venue(context: managedObjectContext)
            
            newVenue.name = venue.name
            newVenue.city = venue.city
            newVenue.venueDescription = venue.venueDescription
            newVenue.longitude = venue.longitude
            newVenue.latitude = venue.latitude
            newVenue.matterportLink = venue.matterportLink
            newVenue.occupancy = venue.occupancy
            newVenue.sqFoot = venue.sqFoot
            newVenue.venueContact = venue.venueContact
            newVenue.fbLink = venue.fbLink
            newVenue.twitLink = venue.twitLink
            newVenue.instaLink = venue.instaLink
            newVenue.venueType = venue.venueType
            newVenue.id = venue.id!
            newVenue.emailTwo = venue.emailTwo
            newVenue.isFeatured = venue.isFeatured
            newVenue.userFullName = venue.userFullName
            newVenue.userEmail = venue.userEmail
            newVenue.createdOn = venue.createdOn
            newVenue.venueRules = venue.venueRules
            
            if venue.venueDetailedPic != nil {
                let venueImages = venue.venueDetailedPic?.components(separatedBy: "|")
                newVenue.venueDetailedPic = venueImages as? NSObject
            }
            
            newVenue.avEquipment = venue.avEquipment
            newVenue.beach = venue.beach
            newVenue.breakOut = venue.breakOut
            newVenue.businessCenter = venue.businessCenter
            newVenue.coatCheck = venue.coatCheck
            newVenue.greatView = venue.greatView
            newVenue.handicapAccessible = venue.handicapAccessible
            newVenue.indoor = venue.indoor
            newVenue.mediaRoom = venue.mediaRoom
            newVenue.non_smoking = venue.smoking
            newVenue.outdoor = venue.outdoor
            newVenue.overnightRooms = venue.overnightRooms
            newVenue.pet_friendly = venue.pet_friendly
            newVenue.rooftop = venue.rooftop
            newVenue.rooms_available = venue.rooms_available
            newVenue.spa = venue.spa
            newVenue.streetParkingTheater = venue.streetParkingTheater
            newVenue.pool = venue.pool
            newVenue.smoking = venue.smoking
            newVenue.valet = venue.valet
            newVenue.wifi = venue.wifi
            
            newVenue.foodInHouse = venue.foodInHouse
            newVenue.foodPreferred = venue.foodPreferred
            newVenue.foodOutside = venue.foodOutside
            
            newVenue.bevInHouse = venue.bevInHouse
            newVenue.bevOutside = venue.bevOutside
            newVenue.bevPreferred = venue.bevPreferred
            newVenue.bevNotAllowed = venue.bevNotAllowed
            
            newVenue.friSatPrice = venue.friSatPrice
            newVenue.friSatBuyoutPrice = venue.friSatBuyoutPrice
            newVenue.sunThursPrice = venue.sunThursPrice
            newVenue.sunThursBuyoutPrice = venue.sunThursBuyoutPrice
            newVenue.weddingsPrice = venue.weddingsPrice
            
            newVenue.monFrom = venue.monFrom
            newVenue.monTo = venue.monTo
            newVenue.monClosed = venue.monClosed
            newVenue.tueFrom = venue.tueFrom
            newVenue.tueTo = venue.tueTo
            newVenue.tueClosed = venue.tueClosed
            newVenue.wedFrom = venue.wedFrom
            newVenue.wedTo = venue.wedTo
            newVenue.wedClosed = venue.wedClosed
            newVenue.thuFrom = venue.thuFrom
            newVenue.thuTo = venue.thuTo
            newVenue.thuClosed = venue.thuClosed
            newVenue.friFrom = venue.friFrom
            newVenue.friTo = venue.friTo
            newVenue.friClosed = venue.friClosed
            newVenue.satFrom = venue.satFrom
            newVenue.satTo = venue.satTo
            newVenue.satClosed = venue.satClosed
            newVenue.sunFrom = venue.sunFrom
            newVenue.sunTo = venue.sunTo
            newVenue.sunClosed = venue.sunClosed
            
            do{
                try managedObjectContext.save()
                self.fetchAllVenueData()
                
            }catch{
                print("There was an error \(error.localizedDescription)")
            }
        }
    }
    
    func clearVendorData() {
        let vendorData: NSFetchRequest<Vendor> = Vendor.fetchRequest()
        do{
            vendors = try managedObjectContext.fetch(vendorData)
            for vendor in vendors {managedObjectContext.delete(vendor)}
            try managedObjectContext.save()
            
        }catch{ print("Could not load data from database") }
    }
    
    func fetchAllVendorData() {
        let vendorData: NSFetchRequest<Vendor> = Vendor.fetchRequest()
        do{
            vendors = try managedObjectContext.fetch(vendorData)
            self.collectionView?.reloadData()
            
        }catch{ print("Could not load data from database") }
        
    }
    
    func saveVendorToCoreData(vendorArray: [VendorDecodable]) {
        
        for vendor in vendorArray {
        
            let newVendor = Vendor(context: managedObjectContext)
            newVendor.id = vendor.id!
            newVendor.name = vendor.name
            newVendor.city = vendor.city
            newVendor.specialization = vendor.specialization
            newVendor.experience = vendor.experience
            newVendor.vendorDescription = vendor.vendorDescription
            newVendor.vendorRate = vendor.vendorRate
            newVendor.vendorContact = vendor.vendorContact
            newVendor.fbLink = vendor.fbLink
            newVendor.twitLink = vendor.twitLink
            newVendor.instaLink = vendor.instaLink
            newVendor.userFullName = vendor.userFullName
            newVendor.userEmail = vendor.userEmail
            newVendor.isFeatured = vendor.isFeatured
            newVendor.createdOn = vendor.createdOn
            newVendor.vendorType = vendor.vendorType
            
            if vendor.vendorDetailedPic != nil {
                let vendorsImages = vendor.vendorDetailedPic?.components(separatedBy: "|")
                newVendor.vendorDetailedPic = vendorsImages as? NSObject
            }
            
            do{
                try managedObjectContext.save()
                self.fetchAllVendorData()
                                
            }catch{
                print("There was an error \(error.localizedDescription)")
            }
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    let segView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var locationButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "CurrentLocationButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleLocationTap), for: .touchUpInside)
        return btn
    }()
    
    func handleLocationTap() {
        
        let currentLatitude = venueMapViewController.venueMapView.userLocation.coordinate.latitude
        let currentLongitude = venueMapViewController.venueMapView.userLocation.coordinate.longitude
        let centerLocation = CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        let regionRadius: CLLocationDistance = 5000
        
        venueMapViewController.venueMapView.showsUserLocation = true
        funcHelper.centerMapOnLocation(location: centerLocation, mapView: venueMapViewController.venueMapView, regionRadius: regionRadius)
        
    }
    
    lazy var vendorButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "VenueVendorToggle_Venue"), for: .normal)
        butt.imageView?.contentMode = .scaleAspectFit
        butt.backgroundColor = .clear
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.isHighlighted = false
        butt.showsTouchWhenHighlighted = false
        butt.adjustsImageWhenHighlighted = false
        butt.addTarget(self, action: #selector(didPressVenueButton), for: .touchUpInside)
        return butt
    }()
    
    lazy var displayMapButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "ListMapToggle_List"), for: .normal)
        butt.imageView?.contentMode = .scaleAspectFit
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.isHighlighted = false
        butt.showsTouchWhenHighlighted = false
        butt.adjustsImageWhenHighlighted = false
        butt.addTarget(self, action: #selector(didPressMapButton), for: .touchUpInside)
        butt.backgroundColor = .white
        return butt
    }()
    
    lazy var editFilterButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "EditFiltersButton"), for: .normal)
        butt.imageView?.contentMode = .scaleAspectFit
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.isHighlighted = false
        butt.showsTouchWhenHighlighted = false
        butt.adjustsImageWhenHighlighted = false
        butt.addTarget(self, action: #selector(didPressEditButton), for: .touchUpInside)
        butt.backgroundColor = .white
        return butt
    }()
    
    let venueMapViewController: MapViewController = {
        let m = MapViewController()
        return m
    }()
    
    let editFiltersViewController: EditFilterController = {
        let e = EditFilterController()
        return e
    }()
    
    let editVendorFiltersViewController: EditVendorsFilterController = {
        let e = EditVendorsFilterController()
        return e
    }()
    
    func setupCollectionView(){

        collectionView?.register(VendorCell.self, forCellWithReuseIdentifier: vendorCellId)
        collectionView?.register(VenueCell.self, forCellWithReuseIdentifier: venueCellId)
        collectionView?.backgroundColor = UIColor(r: 242, g: 242, b: 242)
        collectionView?.showsVerticalScrollIndicator  = false
        collectionView?.showsHorizontalScrollIndicator  = false
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.isPagingEnabled = false
        collectionView?.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 0)
        }
    
    func setupNavView() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .bluVenyard
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    func configureCustomSearchController() {
        
        
        guard let navbar = self.navigationController?.navigationBar else {return}
        
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 0.0, y: 0.0, width: ((navbar.frame.width) / 2), height: 15), searchBarFont: UIFont(name: "Futura", size: 12.0)!, searchBarTextColor: .bluVenyard, searchBarTintColor: .white)
        
        guard let navbarSearch = customSearchController.customSearchBar else {return}
        
        let textField = navbarSearch.value(forKey: "searchField") as! UITextField
        textField.layer.cornerRadius = 0.0
        textField.borderStyle = .none
        
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = .bluVenyard
        
        
        navbarSearch.placeholder = "Search by Location or Name"
        navbarSearch.preferredTextColor = .bluVenyard
        navbarSearch.delegate = self
        
        
        
        navbar.addSubview(locationButton)
        navbar.addSubview(navbarSearch)
        navbar.bringSubview(toFront: locationButton)
        
        navbarSearch.anchor(navbar.topAnchor, left: navbar.leftAnchor, bottom: navbar.bottomAnchor, right: locationButton.leftAnchor, topConstant: 15, leftConstant: 10, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        locationButton.anchor(navbar.topAnchor, left: navbarSearch.rightAnchor, bottom: navbar.bottomAnchor, right: navbar.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)

    }
    
    
    
    func setupSegments(){

        view.addSubview(segView)
        segView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        segView.addSubview(vendorButton)
        segView.addSubview(displayMapButton)
        segView.addSubview(editFilterButton)

        vendorButton.anchor(segView.topAnchor, left: segView.leftAnchor, bottom: segView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 5 , heightConstant: segView.frame.height)
        displayMapButton.anchor(segView.topAnchor, left: vendorButton.rightAnchor , bottom: segView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 5 , heightConstant: segView.frame.height )
        editFilterButton.anchor(segView.topAnchor, left: displayMapButton.rightAnchor, bottom: segView.bottomAnchor, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 12, rightConstant: 10, widthConstant: view.frame.width / 3 - 5 , heightConstant: segView.frame.height)
    }
    
    func setupViews(){
        
        view.addSubview(editFiltersViewController.view)
        editFiltersViewController.view.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        editFiltersViewController.view.isHidden = true
        
        view.addSubview(editVendorFiltersViewController.view)
        editVendorFiltersViewController.view.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        editVendorFiltersViewController.view.isHidden = true
        
        view.addSubview(venueMapViewController.view)
        venueMapViewController.view.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
        venueMapViewController.view.isHidden = true
        
    }
    
    func didPressVenueButton(){
        
        if (vendorButton.currentImage?.isEqual(#imageLiteral(resourceName: "VenueVendorToggle_Venue")))!{
            vendorButton.setImage(#imageLiteral(resourceName: "VenueVendorToggle_Vendor"), for: .normal)
            collectionView?.reloadData()
        }else{
            vendorButton.setImage(#imageLiteral(resourceName: "VenueVendorToggle_Venue"), for: .normal)
            collectionView?.reloadData()
        }
    }
    
    func didPressMapButton(){
        
        if (displayMapButton.currentImage?.isEqual(#imageLiteral(resourceName: "ListMapToggle_List")))!{

            collectionView?.isHidden = true
            venueMapViewController.view.isHidden = false
            displayMapButton.setImage(#imageLiteral(resourceName: "ListMapToggle_Map"), for: .normal)
            
            if CLLocationManager.locationServicesEnabled() {
                switch(CLLocationManager.authorizationStatus()) {
                case .notDetermined, .restricted, .denied:
                    print("No access to maps")
                case .authorizedAlways, .authorizedWhenInUse:
                    venueMapViewController.venueMapView.addAnnotations(funcHelper.plotVenues(venues: venues))
                }
            } else { print("Location services are not enabled") }
            
        }else{
    
            venueMapViewController.view.isHidden = true
            collectionView?.isHidden = false
            displayMapButton.setImage(#imageLiteral(resourceName: "ListMapToggle_List"), for: .normal)
        }
        
    }
    
    func didPressEditButton(){
        
        if (editFilterButton.currentImage?.isEqual(#imageLiteral(resourceName: "EditFiltersButton")))!{
            editFilterButton.setImage(#imageLiteral(resourceName: "EditFiltersButton_Active"), for: .normal)
            
            if (vendorButton.currentImage?.isEqual(#imageLiteral(resourceName: "VenueVendorToggle_Venue")))! {
                editFiltersViewController.view.isHidden = false
            }else{
                editVendorFiltersViewController.view.isHidden = false
            }
            
        }else{
            editFilterButton.setImage(#imageLiteral(resourceName: "EditFiltersButton"), for: .normal)
            editFiltersViewController.view.isHidden = true
            editVendorFiltersViewController.view.isHidden = true
        }
    }

    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
    }
    
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let index = targetContentOffset.pointee.x / view.frame.width
//        
//        let indexPath = NSIndexPath(item: Int(index), section: 0)
//        menu.collecionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
//    }
//    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        menu.leftConstraint?.constant = scrollView.contentOffset.x / 4
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (UIScreen.main.bounds.height) / 3)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (vendorButton.currentImage?.isEqual(#imageLiteral(resourceName: "VenueVendorToggle_Vendor")))!{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: vendorCellId, for: indexPath) as! VendorCell
            let vendor = vendors[indexPath.item]
            cell.datasourceItem = vendor
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: venueCellId, for: indexPath) as! VenueCell
            let venue = venues[indexPath.item]            
            cell.datasourceItem = venue
            return cell
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (vendorButton.currentImage?.isEqual(#imageLiteral(resourceName: "VenueVendorToggle_Vendor")))! {
            return vendors.count
        }else {
            return venues.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
    // MARK: -- SEARCH DELEGATE
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            venues = coreHelper.fetchAllVenueData()!
            self.collectionView?.reloadData()
        }else{
            venues = venues.filter({ (venueModel) -> Bool in
                
                let containsName = (venueModel.name?.lowercased().contains(searchText.lowercased()))!
                
                if !containsName {
                    
                    let containsCity = (venueModel.city?.lowercased().contains(searchText.lowercased()))!
                    
                    if !containsCity {
                        
                    }else{
                        
                        return containsCity
                    }
                
                }else{
                    return containsName
                }
                return false

            })

        self.collectionView?.reloadData()
        }
    }
    
    
    
    
    
    
}





















