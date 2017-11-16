//
//  EditFilterController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/26/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit
import CoreData

class EditFilterController: UIViewController,  UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    var searchFor = [String: Int]()
    var searchResults = [Venue]()
    
    enum VenueTypeCategories: Int {
        case wedding = 1
        case restuarant
        case barLounge
        case church
        case warehouse
        case ballroom
    }

    enum VenueGuestsCategories: Int {
        case onehundred = 1
        case twohundred
        case threehundred
        case fourhundred
        case fivehundred
        case fivehundredplus
    }
    
    enum VenueStyleCategories: Int {
        case modern = 1
        case rustic
        case outside
        case formal
        case elegant
    }
    
    enum VenueAmenities: Int {
        case kitchen = 1
        case danceFloor
        case paSystem
        case barSetup
        case stage
        case outdoorPatio
        case brideGroom
        case coveredPatio
        case anotherAmenity
    }
    
    
    
    //--MARK: MAIN LAYOUT
    
    let refineLabel = UILabel.createLabel(text: "REFINE YOUR SEARCH", size: 16, textColor: .black, fontType: "Bold", backgroundColor: .clear, alignment: .left)
    let venueTypeLabel = UILabel.createLabel(text: "VENUE TYPE", size: 16, textColor: .black, fontType: "Bold", backgroundColor: .clear, alignment: .left)
    let numberOfGuestsLabel = UILabel.createLabel(text: "NUMBER OF GUESTS", size: 16, textColor: .black, fontType: "Bold", backgroundColor: .clear, alignment: .left)
    let venueStyleLabel = UILabel.createLabel(text: "VENUE STYLE", size: 16, textColor: .black, fontType: "Bold", backgroundColor: .clear, alignment: .left)
    let amenitiesLabel = UILabel.createLabel(text: "AMENITIES", size: 16, textColor: .black, fontType: "Bold", backgroundColor: .clear, alignment: .left)
    
    let refineLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let venueTypeLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let numberOfGuestsView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let venueStyleView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let amenitiesView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    
    let refineObjectsView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let venueTypeObjectsView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let numberOfGuestsObjectsView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let venueStyleViewObjectsView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let amenitiesObjectsView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let doneButtonView = UIView.createEmptyViewWithColor(backgroundColor: .bluVenyard)
    
    let venTypeViewLeft = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let venTypeViewRight = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let venGuestsViewLeft = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let venGuestsViewRight = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let venStyleViewLeft = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let venStyleViewRight = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let amenitiesViewLeft = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let amenitiesViewRight = UIView.createEmptyViewWithColor(backgroundColor: .white)
    
    
    //-- MARK: SUB-VIEWS TO MAIN LAYOUT
    
    let weddingLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let restaurantLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let barLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let churchLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let warehouseLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let ballroomLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    
    let oneHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let twoHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let threeHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let fourHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let fiveHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let fivePlusHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    
    let modernLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let rusticLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let outsideLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let formalLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let elegantLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let fillerLabelView = UIView.createEmptyViewWithColor(backgroundColor: .clear)

    let kitchenLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let danceFloorLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let paSystemLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let barSetupLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let stageLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let outdoorPatioLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let brideGroomLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let coveredPatioLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let otherAmenitiesLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let fillerAmenitiesLabelView = UIView.createEmptyViewWithColor(backgroundColor: .clear)
    
    
    //--MARK: SUBVIEWS LABELS
    
    let weddingLabel = UILabel.createLabel(text: "Wedding", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let restaurantLabel = UILabel.createLabel(text: "Restuarant", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let barLoungeLabel = UILabel.createLabel(text: "Bar / Lounge", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let churchLabel = UILabel.createLabel(text: "Church / Chapel", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let warehouseLabel = UILabel.createLabel(text: "Warehouse", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let ballroomLabel = UILabel.createLabel(text: "Ballroom", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    
    let oneHundredLabel = UILabel.createLabel(text: "100 or less", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let twoHundredLabel = UILabel.createLabel(text: "200 or less", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let threeHundredLabel = UILabel.createLabel(text: "300 or less", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let fourHundredLabel = UILabel.createLabel(text: "400 or less", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let fiveHundredLabel = UILabel.createLabel(text: "500 or less", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let fiveHundredPlusLabel = UILabel.createLabel(text: "500+   ", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    
    let modernLabel = UILabel.createLabel(text: "Modern", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let rusticLabel = UILabel.createLabel(text: "Rustic", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let outsideLabel = UILabel.createLabel(text: "Outside", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let formalLabel = UILabel.createLabel(text: "Formal", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let elegantLabel = UILabel.createLabel(text: "Elegant", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    
    let kitchenLabel = UILabel.createLabel(text: "Kitchen", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let danceFloorLabel = UILabel.createLabel(text: "Dance Floor", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let paSystemLabel = UILabel.createLabel(text: "PA System", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let barSetupLabel = UILabel.createLabel(text: "Bar Setup", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let stageLabel = UILabel.createLabel(text: "Stage", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let outdoorPatioLabel = UILabel.createLabel(text: "Outdoor Patio", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let brideGroomLabel = UILabel.createLabel(text: "Bride / Groom Room", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let coveredPatioLabel = UILabel.createLabel(text: "Covered Patio", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let anotherAmenityLabel = UILabel.createLabel(text: "Another Amenities", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    
    lazy var doneButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("DONE", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Bold", size: 14)
        butt.layer.cornerRadius = 1
        butt.backgroundColor = .ventageOrange
        butt.addTarget(self, action: #selector(handlePressedDoneButton), for: .touchUpInside)
        return butt
    }()
    
    let filtersButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("CLEAR FILTERS", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Bold", size: 14)
        butt.layer.cornerRadius = 1
        butt.backgroundColor = .clear
        return butt
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        dismissKeyboardUsingTap(view: (getTopViewController()?.view)!)
        setupViews()
        
    }
    
    
    func handlePressedDoneButton() {
        
        print("Searching for..: ", searchFor)
        
        if let value = searchFor.popFirst() {
            if let valueTwo = searchFor.popFirst() {
                if value.value < 7 && valueTwo.value > 7{
                    fetchVenueByType(type: value.key, guests: valueTwo.key)
                    
                }else{
                    fetchVenueByType(type: valueTwo.key, guests: value.key)
                }
            }
            
            if value.value > 7 {
                fetchVenueByType(type: value.key)
            }else{
                fetchVenueByType(guests: value.key)
            }
            
        }
        
        let tabBarController = CustomTabBarController()
        tabBarController.selectedIndex = 1
        let searchController = tabBarController.selectedViewController as? SearchDatasourceController
        searchController?.venues = self.searchResults
        searchController?.collectionView?.reloadData()
        present(tabBarController, animated: false) {
            
            print("Finished pushing items")
        }
//        present(tabBarController, animated: false, completion: nil)
    }

    func fetchVenueByType(type: String="", guests: String="") {
        
        let venueData: NSFetchRequest<Venue> = Venue.fetchRequest()
        venueData.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [NSPredicate(format: "venueType = %@", type), NSPredicate(format: "occupancy = %@", guests)])
        do{
            searchResults = try managedObjectContext.fetch(venueData)
        }catch{ print("Could not load data from database") }
    }
    
    
    func handleTappedFilterButton(button: UIButton) {
        let selectedAssociatedValue = button.tag
        
        print("selected tag: ", selectedAssociatedValue)
        
        let v = view.viewWithTag(selectedAssociatedValue)
        let categoryLabels: [UILabel] = [weddingLabel, restaurantLabel, barLoungeLabel, churchLabel, warehouseLabel, ballroomLabel, oneHundredLabel, threeHundredLabel, fiveHundredLabel, twoHundredLabel, fourHundredLabel, fiveHundredPlusLabel, modernLabel, rusticLabel, outsideLabel, formalLabel, elegantLabel, kitchenLabel, danceFloorLabel, paSystemLabel, barSetupLabel, anotherAmenityLabel, stageLabel, outdoorPatioLabel, brideGroomLabel, coveredPatioLabel]
        
        if v?.backgroundColor !=  .bluVenyard {
            v?.backgroundColor = .bluVenyard
            categoryLabels[selectedAssociatedValue - 1].textColor = .white
            if selectedAssociatedValue < 7 {
                for i in 1..<7 {
                    if i != selectedAssociatedValue {
                        let vt = view.viewWithTag(i)
                        vt?.isUserInteractionEnabled = false
                    }
                }
                searchFor[String(describing: VenueTypeCategories.init(rawValue: selectedAssociatedValue)!)] = selectedAssociatedValue
            }else if selectedAssociatedValue > 6 && selectedAssociatedValue < 12 {
                for i in 7..<13 {
                    if i != selectedAssociatedValue {
                        let vt = view.viewWithTag(i)
                        vt?.isUserInteractionEnabled = false
                    }
                }
                searchFor[String(describing: VenueGuestsCategories.init(rawValue: selectedAssociatedValue - 6)!)] = selectedAssociatedValue
            }else if selectedAssociatedValue > 12 && selectedAssociatedValue < 18 {
                for i in 13..<18 {
                    if i != selectedAssociatedValue {
                        let vt = view.viewWithTag(i)
                        vt?.isUserInteractionEnabled = false
                    }
                }
//                searchFor.append(String(describing: VenueStyleCategories.init(rawValue: selectedAssociatedValue - 12)!))
            }else if selectedAssociatedValue > 18 && selectedAssociatedValue < 27 {
                for i in 18..<27 {
                    if i != selectedAssociatedValue {
                        let vt = view.viewWithTag(i)
                        vt?.isUserInteractionEnabled = false
                    }
                }
//                searchFor.append(String(describing: VenueAmenities.init(rawValue: selectedAssociatedValue - 18)!))
            }else{}
        }else{
            v?.backgroundColor = .white
            categoryLabels[selectedAssociatedValue - 1].textColor = .black
            if selectedAssociatedValue < 7 {
                for i in 1..<7 {
                    if i != selectedAssociatedValue {
                        let vt = view.viewWithTag(i)
                        vt?.isUserInteractionEnabled = true
                    }
                }
//                let index = searchFor.index(of: String(describing: VenueTypeCategories.init(rawValue: selectedAssociatedValue)!))
                searchFor.removeValue(forKey: String(describing: VenueTypeCategories.init(rawValue: selectedAssociatedValue)!))
                
            }else if selectedAssociatedValue > 6 && selectedAssociatedValue < 12 {
                for i in 7..<13 {
                    if i != selectedAssociatedValue {
                        let vt = view.viewWithTag(i)
                        vt?.isUserInteractionEnabled = true
                    }
                }
//                let index = searchFor.index(of: String(describing: VenueGuestsCategories.init(rawValue: selectedAssociatedValue - 6)!))
                searchFor.removeValue(forKey: String(describing: VenueGuestsCategories.init(rawValue: selectedAssociatedValue - 6)!))
            }else if selectedAssociatedValue > 12 && selectedAssociatedValue < 18 {
                for i in 13..<18 {
                    if i != selectedAssociatedValue {
                        let vt = view.viewWithTag(i)
                        vt?.isUserInteractionEnabled = true
                    }
                }
//                let index = searchFor.index(of: String(describing: VenueStyleCategories.init(rawValue: selectedAssociatedValue - 12)!))
//                searchFor.remove(at: (index?.hashValue)!)
            }else if selectedAssociatedValue > 18 && selectedAssociatedValue < 27{
                for i in 18..<27 {
                    if i != selectedAssociatedValue {
                        let vt = view.viewWithTag(i)
                        vt?.isUserInteractionEnabled = true
                    }
                }
//                let index = searchFor.index(of: String(describing: VenueAmenities.init(rawValue: selectedAssociatedValue - 18)!))
////                searchFor.remove(at: (index?.hashValue)!)
            }else{}
        }
    }
    
    func setupViews() {
        let categoryViews: [UIView] = [weddingLabelView, restaurantLabelView, barLabelView, churchLabelView, warehouseLabelView, ballroomLabelView, oneHundredLabelView, threeHundredLabelView, fiveHundredLabelView, twoHundredLabelView, fourHundredLabelView, fivePlusHundredLabelView, modernLabelView, rusticLabelView, outsideLabelView, formalLabelView, elegantLabelView, kitchenLabelView, danceFloorLabelView, paSystemLabelView, barSetupLabelView, otherAmenitiesLabelView, stageLabelView, outdoorPatioLabelView, brideGroomLabelView, coveredPatioLabelView]
        
        
        let rstraintObjects = UIScreen.main.bounds.height / 5
        let rstraintLabel = UIScreen.main.bounds.height / 15
        let doneButtonConstriant = rstraintLabel + 15
        let scrollHeight: CGFloat = (rstraintObjects * 5) + (rstraintLabel * 6) + doneButtonConstriant
        
        let stackViews: [UIView] = [refineLabelView, refineObjectsView, venueTypeLabelView, venueTypeObjectsView, numberOfGuestsView, numberOfGuestsObjectsView, venueStyleView, venueStyleViewObjectsView, amenitiesView, amenitiesObjectsView, doneButtonView]
        
        let mainStackView = UIStackView.createStackView(views: stackViews, axis: .vertical, distribution: .fill)
        let venueStackView = UIStackView.createStackView(views: [venTypeViewLeft, venTypeViewRight], axis: .horizontal)
        let guestsStackView = UIStackView.createStackView(views: [venGuestsViewLeft, venGuestsViewRight], axis: .horizontal)
        let venueStyleStackView = UIStackView.createStackView(views: [venStyleViewLeft, venStyleViewRight], axis: .horizontal)
        let amenitiesStackView = UIStackView.createStackView(views: [amenitiesViewLeft, amenitiesViewRight], axis: .horizontal)
        
        let venueCategoryStackLeft = UIStackView.createStackView(views: [weddingLabelView, restaurantLabelView, barLabelView], spacing: 10)
        let venueCategoryStackRight = UIStackView.createStackView(views: [churchLabelView, warehouseLabelView, ballroomLabelView], spacing: 10)
        let guestsCategoryStackLeft = UIStackView.createStackView(views: [oneHundredLabelView, threeHundredLabelView, fiveHundredLabelView], spacing: 10)
        let guestsCategoryStackRight = UIStackView.createStackView(views: [twoHundredLabelView, fourHundredLabelView, fivePlusHundredLabelView], spacing: 10)
        let venStyleCategoryLeft = UIStackView.createStackView(views: [modernLabelView, rusticLabelView, outsideLabelView], spacing: 10)
        let venStyleCategoryRight = UIStackView.createStackView(views: [formalLabelView, elegantLabelView, fillerLabelView], spacing: 10)
        let amenitiesCategoryLeft = UIStackView.createStackView(views: [kitchenLabelView, danceFloorLabelView, paSystemLabelView, barSetupLabelView, otherAmenitiesLabelView], spacing: 10)
         let amenitiesCategoryRight = UIStackView.createStackView(views: [stageLabelView, outdoorPatioLabelView, brideGroomLabelView, coveredPatioLabelView, fillerAmenitiesLabelView], spacing: 10)
        
        let scrollview : UIScrollView = {
            let s = UIScrollView(frame: UIScreen.main.bounds)
            s.backgroundColor = .white
            s.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollHeight)
            let insets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
            s.contentInset = insets
            s.scrollIndicatorInsets = insets
            s.showsVerticalScrollIndicator = false
            s.showsHorizontalScrollIndicator = false
            s.bounces = false
            s.delegate = self
            s.translatesAutoresizingMaskIntoConstraints = false
            s.isScrollEnabled = true
            return s
        }()
        
        let locationTextView: UITextField = {
            let tv = UITextField()
            tv.placeholder = "       Houston, TX"
            tv.textAlignment = .left
            tv.textColor = .black
            tv.font = UIFont(name: "Lato-Bold", size: 14)
            tv.backgroundColor = .white
            tv.leftViewMode = .always
            tv.layer.cornerRadius = 5
            tv.layer.borderColor = UIColor.bluVenyard.cgColor
            tv.layer.borderWidth = 2
            return tv
            
        }()
        
        let calendarTextView: UITextField = {
            let tv = UITextField()
            tv.placeholder = "       August 21, 2017"
            tv.textAlignment = .left
            tv.textColor = .black
            tv.font = UIFont(name: "Lato-Bold", size: 14)
            tv.backgroundColor = .white
            tv.leftViewMode = .always
            tv.layer.cornerRadius = 5
            tv.layer.borderColor = UIColor.bluVenyard.cgColor
            tv.layer.borderWidth = 2
            return tv
            
        }()
        
        scrollview.addSubview(mainStackView)
        view.addSubview(scrollview)
        
        //--MARK: ADD MAIN LAYOUT
        
        refineLabelView.addSubview(refineLabel)
        venueTypeLabelView.addSubview(venueTypeLabel)
        numberOfGuestsView.addSubview(numberOfGuestsLabel)
        venueStyleView.addSubview(venueStyleLabel)
        amenitiesView.addSubview(amenitiesLabel)
        
        refineObjectsView.addSubview(locationTextView)
        refineObjectsView.addSubview(calendarTextView)
        venueTypeObjectsView.addSubview(venueStackView)
        numberOfGuestsObjectsView.addSubview(guestsStackView)
        venueStyleViewObjectsView.addSubview(venueStyleStackView)
        amenitiesObjectsView.addSubview(amenitiesStackView)
        
        doneButtonView.addSubview(doneButton)
        doneButtonView.addSubview(filtersButton)
        
        //--MARK: ADD SUBVIEWS TO MAIN LAYOUT
        
        venTypeViewLeft.addSubview(venueCategoryStackLeft)
        venTypeViewRight.addSubview(venueCategoryStackRight)

        venGuestsViewLeft.addSubview(guestsCategoryStackLeft)
        venGuestsViewRight.addSubview(guestsCategoryStackRight)
        
        venStyleViewLeft.addSubview(venStyleCategoryLeft)
        venStyleViewRight.addSubview(venStyleCategoryRight)
        
        amenitiesViewLeft.addSubview(amenitiesCategoryLeft)
        amenitiesViewRight.addSubview(amenitiesCategoryRight)
        
        //--MARK: ADD LABELS TO SUBVIEWS
        
        weddingLabelView.addSubview(weddingLabel)
        weddingLabelView.bringSubview(toFront: weddingLabel)
        
        restaurantLabelView.addSubview(restaurantLabel)
        weddingLabelView.bringSubview(toFront: restaurantLabel)
        
        barLabelView.addSubview(barLoungeLabel)
        barLabelView.bringSubview(toFront: barLoungeLabel)

        churchLabelView.addSubview(churchLabel)
        churchLabelView.bringSubview(toFront: churchLabel)
        
        warehouseLabelView.addSubview(warehouseLabel)
        warehouseLabelView.bringSubview(toFront: warehouseLabel)
        
        ballroomLabelView.addSubview(ballroomLabel)
        ballroomLabelView.bringSubview(toFront: ballroomLabel)
    
        oneHundredLabelView.addSubview(oneHundredLabel)
        oneHundredLabelView.bringSubview(toFront: oneHundredLabel)
        
        twoHundredLabelView.addSubview(twoHundredLabel)
        twoHundredLabelView.bringSubview(toFront: twoHundredLabel)
        
        threeHundredLabelView.addSubview(threeHundredLabel)
        threeHundredLabelView.bringSubview(toFront: threeHundredLabel)
        
        fourHundredLabelView.addSubview(fourHundredLabel)
        fourHundredLabelView.bringSubview(toFront: fourHundredLabel)
        
        fiveHundredLabelView.addSubview(fiveHundredLabel)
        fiveHundredLabelView.bringSubview(toFront: fiveHundredLabel)
        
        fivePlusHundredLabelView.addSubview(fiveHundredPlusLabel)
        fivePlusHundredLabelView.bringSubview(toFront: fiveHundredPlusLabel)
        
        modernLabelView.addSubview(modernLabel)
        modernLabelView.bringSubview(toFront: modernLabel)
        
        rusticLabelView.addSubview(rusticLabel)
        rusticLabelView.bringSubview(toFront: rusticLabel)
        
        outsideLabelView.addSubview(outsideLabel)
        outsideLabelView.bringSubview(toFront: outsideLabel)
        
        formalLabelView.addSubview(formalLabel)
        formalLabelView.bringSubview(toFront: formalLabel)
        
        elegantLabelView.addSubview(elegantLabel)
        elegantLabelView.bringSubview(toFront: elegantLabel)
        
        kitchenLabelView.addSubview(kitchenLabel)
        kitchenLabelView.bringSubview(toFront: kitchenLabel)
        
        danceFloorLabelView.addSubview(danceFloorLabel)
        danceFloorLabelView.bringSubview(toFront: danceFloorLabel)
        
        paSystemLabelView.addSubview(paSystemLabel)
        paSystemLabelView.bringSubview(toFront: paSystemLabel)
        
        barSetupLabelView.addSubview(barSetupLabel)
        barSetupLabelView.bringSubview(toFront: barSetupLabel)
        
        stageLabelView.addSubview(stageLabel)
        stageLabelView.bringSubview(toFront: stageLabel)
        
        outdoorPatioLabelView.addSubview(outdoorPatioLabel)
        outdoorPatioLabelView.bringSubview(toFront: outdoorPatioLabel)
        
        brideGroomLabelView.addSubview(brideGroomLabel)
        brideGroomLabelView.bringSubview(toFront: brideGroomLabel)
        
        coveredPatioLabelView.addSubview(coveredPatioLabel)
        coveredPatioLabelView.bringSubview(toFront: coveredPatioLabel)
        
        otherAmenitiesLabelView.addSubview(anotherAmenityLabel)
        otherAmenitiesLabelView.bringSubview(toFront: anotherAmenityLabel)
        
        //--MARK: CONSTRAINTS FOR MAIN LAYOUT
        
        scrollview.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        mainStackView.anchor(scrollview.topAnchor, left: scrollview.leftAnchor, bottom: scrollview.bottomAnchor, right: scrollview.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width, heightConstant: 0)
        
//        refineLabelView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintLabel)
//        refineLabel.anchor(refineLabelView.topAnchor, left: refineLabelView.leftAnchor, bottom: refineLabelView.bottomAnchor, right: refineLabelView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//        refineObjectsView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintObjects - 50)
//        locationTextView.anchor(refineLabelView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 1.5, heightConstant: rstraintLabel - 10)
//        calendarTextView.anchor(locationTextView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 1.5, heightConstant: rstraintLabel - 10)
//        refineObjectsView.addConstraint(NSLayoutConstraint(item: locationTextView, attribute: .centerX, relatedBy: .equal, toItem: refineObjectsView, attribute: .centerX, multiplier: 1, constant: 0))
//        refineObjectsView.addConstraint(NSLayoutConstraint(item: calendarTextView, attribute: .centerX, relatedBy: .equal, toItem: refineObjectsView, attribute: .centerX, multiplier: 1, constant: 0))
        
        venueTypeLabelView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintLabel)
        venueTypeLabel.anchor(venueTypeLabelView.topAnchor, left: venueTypeLabelView.leftAnchor, bottom: venueTypeLabelView.bottomAnchor, right: venueTypeLabelView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        venueTypeObjectsView.anchor(venueTypeLabelView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintObjects)
        venueStackView.anchor(venueTypeObjectsView.topAnchor, left: venueTypeObjectsView.leftAnchor, bottom: venueTypeObjectsView.bottomAnchor, right: venueTypeObjectsView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        venueCategoryStackLeft.anchor(venTypeViewLeft.topAnchor, left: venTypeViewLeft.leftAnchor, bottom: venTypeViewLeft.bottomAnchor, right: venTypeViewLeft.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        venueCategoryStackRight.anchor(venTypeViewRight.topAnchor, left: venTypeViewRight.leftAnchor, bottom: venTypeViewRight.bottomAnchor, right: venTypeViewRight.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        numberOfGuestsView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintLabel)
        numberOfGuestsLabel.anchor(numberOfGuestsView.topAnchor, left: numberOfGuestsView.leftAnchor, bottom: numberOfGuestsView.bottomAnchor, right: numberOfGuestsView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        numberOfGuestsObjectsView.anchor(numberOfGuestsView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintObjects)
        guestsStackView.anchor(numberOfGuestsObjectsView.topAnchor, left: numberOfGuestsObjectsView.leftAnchor, bottom: numberOfGuestsObjectsView.bottomAnchor, right: numberOfGuestsObjectsView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        guestsCategoryStackLeft.anchor(venGuestsViewLeft.topAnchor, left: venGuestsViewLeft.leftAnchor, bottom: venGuestsViewLeft.bottomAnchor, right: venGuestsViewLeft.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        guestsCategoryStackRight.anchor(venGuestsViewRight.topAnchor, left: venGuestsViewRight.leftAnchor, bottom: venGuestsViewRight.bottomAnchor, right: venGuestsViewRight.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)

        venueStyleView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintLabel)
        venueStyleLabel.anchor(venueStyleView.topAnchor, left: venueStyleView.leftAnchor, bottom: venueStyleView.bottomAnchor, right: venueStyleView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        venueStyleViewObjectsView.anchor(venueStyleView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintObjects)
        venueStyleStackView.anchor(venueStyleViewObjectsView.topAnchor, left: venueStyleViewObjectsView.leftAnchor, bottom: venueStyleViewObjectsView.bottomAnchor, right: venueStyleViewObjectsView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        venStyleCategoryLeft.anchor(venStyleViewLeft.topAnchor, left: venStyleViewLeft.leftAnchor, bottom: venStyleViewLeft.bottomAnchor, right: venStyleViewLeft.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        venStyleCategoryRight.anchor(venStyleViewRight.topAnchor, left: venStyleViewRight.leftAnchor, bottom: venStyleViewRight.bottomAnchor, right: venStyleViewRight.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)

        amenitiesView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintLabel)
        amenitiesLabel.anchor(amenitiesView.topAnchor, left: amenitiesView.leftAnchor, bottom: amenitiesView.bottomAnchor, right: amenitiesView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        amenitiesObjectsView.anchor(amenitiesView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintObjects + 110)
        amenitiesStackView.anchor(amenitiesObjectsView.topAnchor, left: amenitiesObjectsView.leftAnchor, bottom: amenitiesObjectsView.bottomAnchor, right: amenitiesObjectsView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        amenitiesCategoryLeft.anchor(amenitiesViewLeft.topAnchor, left: amenitiesViewLeft.leftAnchor, bottom: amenitiesViewLeft.bottomAnchor, right: amenitiesViewLeft.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        amenitiesCategoryRight.anchor(amenitiesViewRight.topAnchor, left: amenitiesViewRight.leftAnchor, bottom: amenitiesViewRight.bottomAnchor, right: amenitiesViewRight.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        doneButtonView.anchor(amenitiesObjectsView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: doneButtonConstriant)
        doneButton.anchor(doneButtonView.topAnchor, left: nil, bottom: doneButtonView.bottomAnchor, right: doneButtonView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 4, heightConstant: 0)
        filtersButton.anchor(doneButtonView.topAnchor, left: nil, bottom: doneButtonView.bottomAnchor, right: doneButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 3, heightConstant: 0)
        
        weddingLabel.anchor(weddingLabelView.topAnchor, left: venueCategoryStackLeft.leftAnchor, bottom: weddingLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        restaurantLabel.anchor(restaurantLabelView.topAnchor, left: venueCategoryStackLeft.leftAnchor, bottom: restaurantLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        barLoungeLabel.anchor(barLabelView.topAnchor, left: venueCategoryStackLeft.leftAnchor, bottom: barLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        churchLabel.anchor(churchLabelView.topAnchor, left: venueCategoryStackRight.leftAnchor, bottom: churchLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        warehouseLabel.anchor(warehouseLabelView.topAnchor, left: venueCategoryStackRight.leftAnchor, bottom: warehouseLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        ballroomLabel.anchor(ballroomLabelView.topAnchor, left: venueCategoryStackRight.leftAnchor, bottom: ballroomLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        
        oneHundredLabel.anchor(oneHundredLabelView.topAnchor, left: guestsCategoryStackLeft.leftAnchor, bottom: oneHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        twoHundredLabel.anchor(twoHundredLabelView.topAnchor, left: guestsCategoryStackRight.leftAnchor, bottom: twoHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        threeHundredLabel.anchor(threeHundredLabelView.topAnchor, left: guestsCategoryStackLeft.leftAnchor, bottom: threeHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        fourHundredLabel.anchor(fourHundredLabelView.topAnchor, left: guestsCategoryStackRight.leftAnchor, bottom: fourHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        fiveHundredLabel.anchor(fiveHundredLabelView.topAnchor, left: guestsCategoryStackLeft.leftAnchor, bottom: fiveHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        fiveHundredPlusLabel.anchor(fivePlusHundredLabelView.topAnchor, left: guestsCategoryStackRight.leftAnchor, bottom: fivePlusHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        
        modernLabel.anchor(modernLabelView.topAnchor, left: venStyleCategoryLeft.leftAnchor, bottom: modernLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        rusticLabel.anchor(rusticLabelView.topAnchor, left: venStyleCategoryLeft.leftAnchor, bottom: rusticLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        outsideLabel.anchor(outsideLabelView.topAnchor, left: venStyleCategoryLeft.leftAnchor, bottom: outsideLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        formalLabel.anchor(formalLabelView.topAnchor, left: venStyleCategoryRight.leftAnchor, bottom: formalLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        elegantLabel.anchor(elegantLabelView.topAnchor, left: venStyleCategoryRight.leftAnchor, bottom: elegantLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)

        kitchenLabel.anchor(kitchenLabelView.topAnchor, left: amenitiesCategoryLeft.leftAnchor, bottom: kitchenLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        danceFloorLabel.anchor(danceFloorLabelView.topAnchor, left: amenitiesCategoryLeft.leftAnchor, bottom: danceFloorLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        paSystemLabel.anchor(paSystemLabelView.topAnchor, left: amenitiesCategoryLeft.leftAnchor, bottom: paSystemLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        barSetupLabel.anchor(barSetupLabelView.topAnchor, left: amenitiesCategoryLeft.leftAnchor, bottom: barSetupLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        stageLabel.anchor(stageLabelView.topAnchor, left: amenitiesCategoryRight.leftAnchor, bottom: stageLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        outdoorPatioLabel.anchor(outdoorPatioLabelView.topAnchor, left: amenitiesCategoryRight.leftAnchor, bottom: outdoorPatioLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        brideGroomLabel.anchor(brideGroomLabelView.topAnchor, left: amenitiesCategoryRight.leftAnchor, bottom: brideGroomLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        coveredPatioLabel.anchor(coveredPatioLabelView.topAnchor, left: amenitiesCategoryRight.leftAnchor, bottom: coveredPatioLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        anotherAmenityLabel.anchor(otherAmenitiesLabelView.topAnchor, left: amenitiesCategoryLeft.leftAnchor, bottom: otherAmenitiesLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        
        var counter = 1
        for view in categoryViews {
            let button: UIButton = {
                let btn = UIButton()
                btn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2 - 35, height: 30)
                btn.tag = counter
                btn.addTarget(self, action: #selector(handleTappedFilterButton), for: .touchUpInside)
                return btn
            }()
            
            view.addSubview(button)
            view.tag = counter
            counter += 1
        }
      
    }
    
    func addViewsHelper(views: [UIView], labels: [UILabel]) {
        var counter = 0
        for _ in 0...views.count {
            views[counter].addSubview(labels[counter])
            views[counter].bringSubview(toFront: labels[counter])
            counter += 1
        }
    }
    
   
    
}
