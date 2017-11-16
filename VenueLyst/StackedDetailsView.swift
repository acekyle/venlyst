//
//  StackedDetailsView.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/26/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit
import MapKit
import LBTAComponents
import CoreData
import Social

class StackedDetailsView: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var currentVenueId: Int?
    var currentPicture = 0
    var currentUser: User?
    let coreHelper = CoreStack()
    let funcHelper = HelperFunctions()
    var pictureArray = [String]()
    
    var venueObject: Venue? {
        didSet {
            
            //-- SETUP venue details--//
            
            guard let venue = venueObject else { return }
            
            print("Venue Name from Detailed: ", venue.name)
//            let address = venue.city?.components(separatedBy: ",")

            currentVenueId = Int(venue.id!)

            if let venuePictures = venue.venueDetailedPic as? [String] {
                detailedVenueImage.loadImage(urlString: venuePictures[0], completion: {
                    self.pictureArray = venuePictures
                })
            }
            
            venueLabel.text = venue.name
            venueTypeLabel.text = venue.venueType
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5
            let attributes = [NSParagraphStyleAttributeName : style]
            venueDescription.attributedText = NSAttributedString(string: venue.venueDescription!, attributes: attributes)
            
            friSatSubLabel.text = "\(String(describing: venue.friSatPrice != "" ? venue.friSatPrice! : "Contact Venue" ))"
            sunThursSubLabel.text = "\(String(describing: venue.sunThursPrice != "" ? venue.sunThursPrice! : "Contact Venue"))"
            buyoutSubLabel.text = "\(String(describing: venue.friSatBuyoutPrice != "" ? venue.friSatBuyoutPrice! : "Contact Venue"))"
            
            occupancySubLabel.text = venue.occupancy
            lookFeelSubLabel.text = venue.venueType
            sqFootSubLabel.text = venue.sqFoot
            
            tourFriSatSubLabel.text = "\(venue.friFrom ?? "") - \(venue.satTo ?? "")"
            tourSunThursSubLabel.text = "\(venue.sunFrom ?? "") - \(venue.thuTo ?? "")"
            
            venueAddressLabel.text = "\(venue.city ?? "")"
            venueMapViewController.venueMapView.addAnnotations(funcHelper.plotVenues(venues: [venueObject!]))
            
            if venue.matterportLink != nil  {
                 matterportController.webView.loadHTMLString(venue.matterportLink ?? "", baseURL: nil)
            }
            
            guard let venuePhone = Int(venue.venueContact!) else { return }
            contactButton.tag = venuePhone
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        checkIfLiked()
        
        matterportVideoView.isHidden = true
        mapView.isUserInteractionEnabled = false
        
        nextPicButton.isHidden = true
        if pictureArray.count > 1 {
            self.nextPicButton.isHidden = false
        }
        
        if (venueObject?.matterportLink?.count)! < 5 {
            detailedThreeDButton.isHidden = true
        }
        
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) { UIApplication.shared.statusBarStyle = .lightContent }
    
    
    // MARK -- 10 Views -- DONT FORGET TO CALL CONSTRAINTS
    
    let blueView = UIView.createEmptyViewWithColor(backgroundColor: .bluVenyard)
    let backAndShareButtonView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let detailedVenueImageView = UIView.createEmptyViewWithColor(backgroundColor: .lightGray)
    let venueNameAndDescriptionView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let priceAndDateLabelView = UIView.createEmptyViewWithColor(backgroundColor: .bluVenyard)
    let detailsAndOccupancyView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let touringAndAppointmentView = UIView.createEmptyViewWithColor(backgroundColor: .bluVenyard)
    let amenitiesAndImagesView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let locationLabelView = UIView.createEmptyViewWithColor(backgroundColor: .bluVenyard)
    let mapView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    
    let linkButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("BACK TO RESULTS", for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        butt.backgroundColor = UIColor.ventageOrange
        butt.addTarget(self, action: #selector(backToResults), for: .touchUpInside)
        return butt
    }()
    
    
    // -- MARK -- SOCIAL MEDIA BUTTONS
    
    
    let fbButton = UIButton.createButton(image: #imageLiteral(resourceName: "Facebook"))
    let tweetButton = UIButton.createButton(image: #imageLiteral(resourceName: "Twitter"))
    let instaButton = UIButton.createButton(image: #imageLiteral(resourceName: "Instagram"))
    let shareButton = UIButton.createButton(image: #imageLiteral(resourceName: "Share"))
    
    func shareTapped() {
        
        let text = "Check out this venue I found on Venuelyst!! \(venueObject?.name ?? "")"
        let vc = UIActivityViewController(activityItems: [text , pictureArray[currentPicture]], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    // -- MARK -- VENUE IMAGE VIEW ITEMS
    
    let detailedVenueImage: CachedImageView = {
        let imgView = CachedImageView()
        imgView.backgroundColor = .black
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage()
        return imgView
    }()
    
    let favButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "likeButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(handleHeartTap), for: .touchUpInside)
        return btn
    }()
    
    let detailedPlayButton = UIButton.createButton(image: #imageLiteral(resourceName: "PlayButton"))

    let detailedThreeDButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "MatterportButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(handleMatterPortButton), for: .touchUpInside)
        return btn
    }()
    
    let matterportVideoView = UIView.createEmptyViewWithColor(backgroundColor: .red)
    
    let matterportController: WebViewController = {
        let matterC = WebViewController()
        matterC.tag = 11
        matterC.linkButton.titleLabel?.text = "Back to Venue"
        matterC.webView.loadHTMLString("", baseURL: nil)
        return matterC
    }()
    
    func handleMatterPortButton() {
        
        present(matterportController, animated: false, completion: nil)
        
    }
    
    let nextPicButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "right-chevron"), for: .normal)
        butt.addTarget(self, action: #selector(changePic), for: .touchUpInside)
        return butt
    }()
    
    func changePic(){
        if pictureArray.count == currentPicture + 1 {
            currentPicture = 0
        }else{
            currentPicture += 1
        }
        detailedVenueImage.loadImage(urlString: pictureArray[currentPicture])
    }
    
    let venueLabel = UILabel.createLabel(text: "Le Playhouse", size: 18, textColor: .black, fontType: "Bold")
    let venueTypeLabel = UILabel.createLabel(text: "Strip Joint", size: 16, textColor: .ventageOrange, fontType: "Light")

    let venueDescription: UITextView = {
        let tv = UITextView()
        tv.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        //            tv.backgroundColor = .green
        tv.tintColor = .green
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    lazy var contactButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("CONTACT THIS VENUE", for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        butt.backgroundColor = UIColor.ventageOrange
        butt.addTarget(self, action: #selector(handleContactButtonPressed), for: .touchUpInside)
        return butt
    }()
    
    func handleContactButtonPressed() {
        makeCall(phone: "\(contactButton.tag)")
    }

    func makeCall(phone: String) {
        let number = phone.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
        let phoneUrl = "tel://\(number)"
        let url:NSURL = NSURL(string: phoneUrl)!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        //        UIApplication.shared.openURL(url as URL)
    }
    
    // -- MARK -- STARTING PRICE ITEMS
    

    let startingPriceLabel = UILabel.createLabel(text: "STARTING PRICES", size: 16, textColor: .white, fontType: "Bold", alignment: .left)
    
    let friSatLabel = UILabel.createLabel(text: "FRI - SAT:", size: 12, textColor: .white, fontType: "Bold", alignment: .left)
    let sunThursLabel = UILabel.createLabel(text: "SUN - THURS:", size: 12, textColor: .white, fontType: "Bold", alignment: .left)
    let buyoutLabel = UILabel.createLabel(text: "BUYOUT:", size: 12, textColor: .white, fontType: "Bold", alignment: .left)
    let friSatSubLabel = UILabel.createLabel(text: "Call for quote", size: 14, textColor: .white, fontType: "Light", alignment: .left)
    let sunThursSubLabel = UILabel.createLabel(text: "Call for quote", size: 14, textColor: .white, fontType: "Light", alignment: .left)
    let buyoutSubLabel = UILabel.createLabel(text: "Call for quote", size: 14, textColor: .white, fontType: "Light", alignment: .left)
    
    let headingBarPriceImage: CachedImageView = {
        let imgView = CachedImageView()
        imgView.backgroundColor = .black
        imgView.layer.masksToBounds = true
        imgView.image = #imageLiteral(resourceName: "OrangeHeadingBar")
        return imgView
    }()
    

    
    // -- MARK -- DEATAILS VIEW ITEMS
    
    
    let detailsLabel = UILabel.createLabel(text: "DETAILS", size: 16, textColor: .black, fontType: "Bold", alignment: .left)
    let occupancyLabel = UILabel.createLabel(text: "OCCUPANCY:", size: 12, textColor: .black, fontType: "Bold", alignment: .left)
    let lookFeelLabel = UILabel.createLabel(text: "LOOK & FEEL:", size: 12, textColor: .black, fontType: "Bold", alignment: .left)
    let sqFootLabel = UILabel.createLabel(text: "SQ FOOTAGE:", size: 12, textColor: .black, fontType: "Bold", alignment: .left)
    
    let occupancySubLabel = UILabel.createLabel(text: "Max. 400 pop", size: 12, textColor: .black, fontType: "Light", alignment: .left)
    let lookFeelSubLabel = UILabel.createLabel(text: "Formal, Wedding", size: 12, textColor: .black, fontType: "Light", alignment: .left)
    let sqFootSubLabel = UILabel.createLabel(text: "4,000 Sqft", size: 12, textColor: .black, fontType: "Light", alignment: .left)

    let headingBarDetailsImage: CachedImageView = {
        let imgView = CachedImageView()
        imgView.backgroundColor = .black
        imgView.layer.masksToBounds = true
        imgView.image = #imageLiteral(resourceName: "OrangeHeadingBar")
        return imgView
    }()
    
    
    
    // -- MARK -- TOURING HOURS VIEW ITEMS
    
    
    let touringLabel = UILabel.createLabel(text: "TOURING HOURS", size: 16, textColor: .white, fontType: "Bold", alignment: .left)
    let makeAppointmentLabel = UILabel.createLabel(text: "MUST MAKE AN APPOINTMENT", size: 12, textColor: .white, fontType: "Bold", alignment: .left)
    let tourFriSatLabel = UILabel.createLabel(text: "FRI - SAT:", size: 12, textColor: .white, fontType: "Bold", alignment: .left)
    let tourSunThursLabel = UILabel.createLabel(text: "SUN - THURS:", size: 12, textColor: .white, fontType: "Bold", alignment: .left)
    
    let tourFriSatSubLabel = UILabel.createLabel(text: "10am - 4pm", size: 14, textColor: .white, fontType: "Light", alignment: .left)
    let tourSunThursSubLabel = UILabel.createLabel(text: "10am - 2am", size: 14, textColor: .white, fontType: "Light", alignment: .left)
  
    let headingBarTouringImage: CachedImageView = {
        let imgView = CachedImageView()
        imgView.backgroundColor = .black
        imgView.layer.masksToBounds = true
        imgView.image = #imageLiteral(resourceName: "OrangeHeadingBar")
        return imgView
    }()
    
    
    // -- MARK -- AMENETITIES VIEW ITEMS
    
    let topViewLeft = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let topViewRight = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let bottomViewLeft = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let bottomViewRight = UIView.createEmptyViewWithColor(backgroundColor: .white)
    
    
    let amenitiesLabel: UILabel = {
        let lab = UILabel()
        lab.text = "AMENITIES"
        lab.textColor = .black
        lab.font = UIFont(name: "Lato-Bold", size: 18)
        //            lab.backgroundColor = .purple
        return lab
    }()
    
    let headingBarImage: CachedImageView = {
        let imgView = CachedImageView()
        imgView.backgroundColor = .black
        imgView.layer.masksToBounds = true
        imgView.image = #imageLiteral(resourceName: "OrangeHeadingBar")
        return imgView
    }()
    
    let fullBarLabel: UILabel = {
        let lab = UILabel()
        lab.text = "FULL BAR"
        lab.textColor = .black
        lab.font = UIFont(name: "Lato-Bold", size: 16)
        //                        lab.backgroundColor = .gray
        return lab
    }()
    
    let wifiLabel: UILabel = {
        let lab = UILabel()
        lab.text = "FREE WIFI"
        //            lab.textColor = .black
        lab.font = UIFont(name: "Lato-Bold", size: 16)
        //            lab.backgroundColor = .purple
        return lab
    }()
    
    let cateringLabel: UILabel = {
        let lab = UILabel()
        lab.text = "CATERING"
        lab.textColor = .black
        lab.font = UIFont(name: "Lato-Bold", size: 16)
        //            lab.backgroundColor = .gray
        return lab
    }()
    
    let shuttleLabel: UILabel = {
        let lab = UILabel()
        lab.text = "SHUTTLE"
        lab.textColor = .black
        lab.font = UIFont(name: "Lato-Bold", size: 16)
        //            lab.backgroundColor = .purple
        return lab
    }()
    
    let fullBarImage: CachedImageView = {
        let imgView = CachedImageView()
        //            imgView.backgroundColor = .black
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.image = #imageLiteral(resourceName: "BarIcon")
        return imgView
    }()
    
    let wifiImage: CachedImageView = {
        let imgView = CachedImageView()
        //            imgView.backgroundColor = .black
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.image = #imageLiteral(resourceName: "WifiIcon")
        return imgView
    }()
    
    let cateringImage: CachedImageView = {
        let imgView = CachedImageView()
        //            imgView.backgroundColor = .black
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.image = #imageLiteral(resourceName: "CateringIcon")
        return imgView
    }()
    
    let shuttleImage: CachedImageView = {
        let imgView = CachedImageView()
        //            imgView.backgroundColor = .black
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.image = #imageLiteral(resourceName: "ShuttleIcon")
        return imgView
    }()
    
    let venueAddressLabel: UILabel = {
        let lab = UILabel()
        lab.text = "123 Slickback Rd, Houston, TX 77007"
        lab.textColor = .white
        lab.font = UIFont(name: "Lato-Bold", size: 12)
        //            lab.backgroundColor = .gray
        return lab
    }()

    
    //MARK: -- MAP VIEW ITEMS --
    
    
    let venueMapViewController: MapViewController = {
        let m = MapViewController()
        return m
    }()
    
    
    //MARK: -- FUNCTIONS --
    
    func backToResults(){
        
        self.dismiss(animated: false) {
//            let tabBarController = CustomTabBarController()
//            tabBarController.selectedIndex = 1
//            self.present(tabBarController, animated: false, completion: nil)
        }
    }

    func stackHeight(heights: [CGFloat]) -> CGFloat {
        var height: CGFloat = 0.0
        for f in heights{
            height += f
        }
        return height
    }
    
    func checkIfLiked(){
        guard let user = coreHelper.fetchUserData() else { return }
        
        if user.count > 0 {
            currentUser = user[0]
            
            let currentfavs = currentUser?.favorites as! [String]
            if let currentIdTemp = currentVenueId {
                let currentId = String(currentIdTemp)
                if currentfavs.contains(currentId){
                    favButton.setImage(#imageLiteral(resourceName: "likeButtonFilled"), for: .normal)
                }
            }
        }   
    }
    
    func handleHeartTap(){
        if (favButton.currentImage?.isEqual(#imageLiteral(resourceName: "likeButton")))! {
            favButton.setImage(#imageLiteral(resourceName: "likeButtonFilled"), for: .normal)

            // MARK: -- GET CURRENT VENUE ID --
            
            if currentVenueId != nil {
                
                var currentFavoritesArray = currentUser?.value(forKey: "favorites") as! [String]
                let currentId = String(describing: currentVenueId!)

    
                if !currentFavoritesArray.contains(currentId) {
                    currentFavoritesArray.append(currentId)
                    coreHelper.updateUserFavorites(value: currentFavoritesArray)
                        
                    guard let user = coreHelper.fetchUserData()?[0] else { return }
                    currentUser = user
                        
                }else{}
            }
      
        }else{
            favButton.setImage(#imageLiteral(resourceName: "likeButton"), for: .normal)
            
            if currentVenueId != nil {
                
                var currentFavoritesArray = currentUser?.value(forKey: "favorites") as! [String]
                let currentId = String(describing: currentVenueId!)
                    
                currentFavoritesArray = currentFavoritesArray.filter { $0 != currentId }
                    
                coreHelper.updateUserFavorites(value: currentFavoritesArray)
                
                guard let user = coreHelper.fetchUserData()?[0] else { return }
                currentUser = user
                
            }
        }
    }

    func setupViews(){
        
        let stackViews: [UIView] = [blueView, backAndShareButtonView, detailedVenueImageView, venueNameAndDescriptionView, priceAndDateLabelView, detailsAndOccupancyView, touringAndAppointmentView, amenitiesAndImagesView, locationLabelView, mapView]
        
        let blueStraint: CGFloat = UIScreen.main.bounds.height / 25
        let backStraint: CGFloat = UIScreen.main.bounds.height / 13.7
        let imageStraint: CGFloat = UIScreen.main.bounds.height / 3.3
        let descriptStraint: CGFloat = UIScreen.main.bounds.height / 2.7
        let priceStraint: CGFloat = UIScreen.main.bounds.height / 6
        let detailsStraint: CGFloat = UIScreen.main.bounds.height / 6
        let touringStraint: CGFloat = UIScreen.main.bounds.height / 5.5
        let amenStraint: CGFloat = UIScreen.main.bounds.height / 2.7
        let locateStraint: CGFloat = UIScreen.main.bounds.height / 13
        let mapStraint: CGFloat = UIScreen.main.bounds.height / 3.5
        
        let floatsStraints: [CGFloat] = [blueStraint, backStraint, imageStraint, descriptStraint, priceStraint, detailsStraint, touringStraint, amenStraint, locateStraint, mapStraint]
        
        let scrollview : UIScrollView = {
            let s = UIScrollView(frame: UIScreen.main.bounds)
            s.backgroundColor = .bluVenyard
            s.contentSize = CGSize(width: UIScreen.main.bounds.width, height: stackHeight(heights: floatsStraints))
            let insets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
            s.contentInset = insets
            s.scrollIndicatorInsets = insets
            s.showsVerticalScrollIndicator = false
            s.showsHorizontalScrollIndicator = false
            s.bounces = false
            s.delegate = self
            return s
        }()
        
        let stackView: UIStackView = {
            let stack =  UIStackView(arrangedSubviews: stackViews)
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 0
            return stack
        }()

        
        scrollview.addSubview(stackView)
        view.addSubview(scrollview)
//        view.addSubview(nextPicButton)
        
        scrollview.anchor(topLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        stackView.anchor(scrollview.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 0)
        
        blueView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: blueStraint)
        backAndShareButtonView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: backStraint)
        detailedVenueImageView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: imageStraint)
        venueNameAndDescriptionView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: descriptStraint)
        priceAndDateLabelView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: priceStraint)
        detailsAndOccupancyView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: detailsStraint)
        touringAndAppointmentView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: touringStraint)
        amenitiesAndImagesView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: amenStraint)
        locationLabelView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: locateStraint)
        mapView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: mapStraint)
        
        
        var shopLocation = CLLocationCoordinate2D(latitude: 29.562696, longitude: -95.563955)
        
        let backViewButtons: [UIButton] = [linkButton, fbButton, tweetButton, instaButton, shareButton]
        let venueImageViewItems: [Any] = [nextPicButton, detailedThreeDButton]
        let descriptionViewItems: [Any] = [venueLabel, venueTypeLabel, venueDescription, contactButton]
        let amenitiesViewItems: [Any] = [amenitiesLabel, headingBarImage, topViewLeft, topViewRight, bottomViewRight, bottomViewLeft]
        let startingPriceViewItems: [Any] = [startingPriceLabel, headingBarPriceImage, friSatLabel, friSatSubLabel, sunThursLabel, sunThursSubLabel, buyoutLabel, buyoutSubLabel]
        let detailsViewItems: [Any] = [detailsLabel, headingBarDetailsImage, occupancyLabel, occupancySubLabel, lookFeelLabel, lookFeelSubLabel, sqFootLabel, sqFootSubLabel ]
        let touringHoursViewItems: [Any] = [touringLabel, headingBarTouringImage, makeAppointmentLabel, tourFriSatLabel, tourFriSatSubLabel, tourSunThursLabel, tourSunThursSubLabel]
        
        func addSubviews(objects: [Any], view: UIView=view){for o in objects{view.addSubview(o as! UIView)}}
        
        detailedVenueImageView.addSubview(detailedVenueImage)
        detailedVenueImageView.addSubview(matterportVideoView)
        detailedVenueImageView.addSubview(favButton)
        locationLabelView.addSubview(venueAddressLabel)
        mapView.addSubview(venueMapViewController.venueMapView)
        
        addSubviews(objects: venueImageViewItems, view: view)
        addSubviews(objects: backViewButtons, view: backAndShareButtonView)
        addSubviews(objects: descriptionViewItems, view: venueNameAndDescriptionView)
        addSubviews(objects: amenitiesViewItems, view: amenitiesAndImagesView)

        addSubviews(objects: [fullBarLabel, fullBarImage], view: topViewLeft)
        addSubviews(objects: [wifiLabel, wifiImage], view: topViewRight)
        addSubviews(objects: [cateringLabel, cateringImage], view: bottomViewLeft)
        addSubviews(objects: [shuttleLabel, shuttleImage], view: bottomViewRight)
        
        addSubviews(objects: startingPriceViewItems, view: priceAndDateLabelView)
        addSubviews(objects: detailsViewItems, view: detailsAndOccupancyView)
        addSubviews(objects: touringHoursViewItems, view: touringAndAppointmentView)
        
        linkButton.anchor(backAndShareButtonView.topAnchor, left: backAndShareButtonView.leftAnchor, bottom: backAndShareButtonView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3.1, heightConstant: 0)
       
        shareButton.anchor(backAndShareButtonView.topAnchor, left: nil, bottom: backAndShareButtonView.bottomAnchor, right: backAndShareButtonView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 9, heightConstant: 0)
        instaButton.anchor(backAndShareButtonView.topAnchor, left: nil, bottom: backAndShareButtonView.bottomAnchor, right: shareButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 9, heightConstant: 0)
        tweetButton.anchor(backAndShareButtonView.topAnchor, left: nil, bottom: backAndShareButtonView.bottomAnchor, right: instaButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 9, heightConstant: 0)
        fbButton.anchor(backAndShareButtonView.topAnchor, left: nil, bottom: backAndShareButtonView.bottomAnchor, right: tweetButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 9, heightConstant: 0)
        

        nextPicButton.anchor(detailedVenueImage.topAnchor, left: nil, bottom: nil, right: detailedVenueImageView.rightAnchor, topConstant: (view.frame.height / 2.7) / 3.5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 48, heightConstant: 48)
        
        detailedVenueImage.anchor(detailedVenueImageView.topAnchor, left: detailedVenueImageView.leftAnchor, bottom: detailedVenueImageView.bottomAnchor, right: detailedVenueImageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        matterportVideoView.anchor(detailedVenueImageView.topAnchor, left: detailedVenueImageView.leftAnchor, bottom: detailedVenueImageView.bottomAnchor, right: detailedVenueImageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        detailedThreeDButton.anchor(nil, left: nil, bottom: detailedVenueImage.bottomAnchor, right: detailedVenueImageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: view.frame.width / 9, heightConstant: detailedVenueImageView.frame.height / 6)
//        detailedPlayButton.anchor(nil, left: nil, bottom: detailedVenueImage.bottomAnchor, right: detailedThreeDButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: view.frame.width / 9, heightConstant: detailedVenueImageView.frame.height / 6)
        favButton.anchor(detailedVenueImage.topAnchor, left: nil, bottom: nil, right: detailedVenueImage.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: view.frame.width / 10, heightConstant: view.frame.height / 20)
        
        venueLabel.anchor(venueNameAndDescriptionView.topAnchor, left: venueNameAndDescriptionView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        venueTypeLabel.anchor(venueLabel.bottomAnchor, left: venueNameAndDescriptionView.leftAnchor, bottom: nil, right: nil, topConstant: 2, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        venueDescription.anchor(venueTypeLabel.bottomAnchor, left: venueNameAndDescriptionView.leftAnchor, bottom: venueNameAndDescriptionView.bottomAnchor, right: venueNameAndDescriptionView.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 75, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        contactButton.anchor(venueDescription.bottomAnchor, left: venueNameAndDescriptionView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 10, rightConstant: 0, widthConstant: 150, heightConstant: 35)
        
        
        startingPriceLabel.anchor(priceAndDateLabelView.topAnchor, left: priceAndDateLabelView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        headingBarPriceImage.anchor(startingPriceLabel.bottomAnchor, left: priceAndDateLabelView.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 6, heightConstant: 3)
        friSatLabel.anchor(headingBarPriceImage.bottomAnchor, left: priceAndDateLabelView.leftAnchor, bottom: nil, right: nil, topConstant: 23, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 15, heightConstant: 0)
        friSatSubLabel.anchor(friSatLabel.bottomAnchor, left: priceAndDateLabelView.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        sunThursLabel.anchor(headingBarPriceImage.bottomAnchor, left: friSatLabel.rightAnchor, bottom: nil, right: nil, topConstant: 23, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 15, heightConstant: 0)
        sunThursSubLabel.anchor(friSatLabel.bottomAnchor, left: sunThursLabel.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        buyoutLabel.anchor(headingBarPriceImage.bottomAnchor, left: sunThursLabel.rightAnchor, bottom: nil, right: nil, topConstant: 23, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 15, heightConstant: 0)
        buyoutSubLabel.anchor(friSatLabel.bottomAnchor, left: buyoutLabel.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        detailsLabel.anchor(detailsAndOccupancyView.topAnchor, left: detailsAndOccupancyView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        headingBarDetailsImage.anchor(detailsLabel.bottomAnchor, left: detailsAndOccupancyView.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 6, heightConstant: 3)
        occupancyLabel.anchor(headingBarDetailsImage.bottomAnchor, left: detailsAndOccupancyView.leftAnchor, bottom: nil, right: nil, topConstant: 23, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 15, heightConstant: 0)
        occupancySubLabel.anchor(occupancyLabel.bottomAnchor, left: detailsAndOccupancyView.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        lookFeelLabel.anchor(headingBarDetailsImage.bottomAnchor, left: occupancyLabel.rightAnchor, bottom: nil, right: nil, topConstant: 23, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 15, heightConstant: 0)
        lookFeelSubLabel.anchor(lookFeelLabel.bottomAnchor, left: lookFeelLabel.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        sqFootLabel.anchor(headingBarDetailsImage.bottomAnchor, left: lookFeelLabel.rightAnchor, bottom: nil, right: nil, topConstant: 23, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 15, heightConstant: 0)
        sqFootSubLabel.anchor(sqFootLabel.bottomAnchor, left: sqFootLabel.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        

        touringLabel.anchor(touringAndAppointmentView.topAnchor, left: touringAndAppointmentView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        headingBarTouringImage.anchor(touringLabel.bottomAnchor, left: touringAndAppointmentView.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 6, heightConstant: 3)
        makeAppointmentLabel.anchor(headingBarTouringImage.bottomAnchor, left: touringAndAppointmentView.leftAnchor, bottom: nil, right: nil, topConstant: 13, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: 0)
        tourFriSatLabel.anchor(makeAppointmentLabel.bottomAnchor, left: touringAndAppointmentView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 15, heightConstant: 0)
        tourFriSatSubLabel.anchor(tourFriSatLabel.bottomAnchor, left: touringAndAppointmentView.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        tourSunThursLabel.anchor(makeAppointmentLabel.bottomAnchor, left: tourFriSatLabel.rightAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 3 - 15, heightConstant: 0)
        tourSunThursSubLabel.anchor(tourSunThursLabel.bottomAnchor, left: tourSunThursLabel.leftAnchor, bottom: nil, right: nil, topConstant: 1, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        

        amenitiesLabel.anchor(amenitiesAndImagesView.topAnchor, left: amenitiesAndImagesView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        headingBarImage.anchor(amenitiesLabel.bottomAnchor, left: amenitiesAndImagesView.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 6, heightConstant: 3)

        topViewLeft.anchor(headingBarImage.bottomAnchor, left: amenitiesAndImagesView.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: amenStraint / 2.5)
        topViewRight.anchor(headingBarImage.bottomAnchor, left: nil, bottom: nil, right: amenitiesAndImagesView.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: amenStraint / 2.5)
        bottomViewLeft.anchor(topViewLeft.bottomAnchor, left: amenitiesAndImagesView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: amenStraint / 2.5)
        bottomViewRight.anchor(topViewLeft.bottomAnchor, left: nil, bottom: nil, right: amenitiesAndImagesView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 2, heightConstant: amenStraint / 2.5)
        
        fullBarImage.anchor(topViewLeft.topAnchor, left: topViewLeft.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        fullBarLabel.anchor(topViewLeft.topAnchor, left: fullBarImage.rightAnchor, bottom: topViewLeft.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        wifiImage.anchor(topViewRight.topAnchor, left: topViewRight.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        wifiLabel.anchor(topViewRight.topAnchor, left: wifiImage.rightAnchor, bottom: topViewRight.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        cateringImage.anchor(bottomViewLeft.topAnchor, left: bottomViewLeft.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        cateringLabel.anchor(bottomViewLeft.topAnchor, left: cateringImage.rightAnchor, bottom: bottomViewLeft.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        shuttleImage.anchor(bottomViewRight.topAnchor, left: bottomViewRight.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        shuttleLabel.anchor(bottomViewRight.topAnchor, left: shuttleImage.rightAnchor, bottom: bottomViewRight.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        venueAddressLabel.anchor(locationLabelView.topAnchor, left: locationLabelView.leftAnchor, bottom: locationLabelView.bottomAnchor, right: locationLabelView.rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        venueMapViewController.venueMapView.anchor(mapView.topAnchor, left: mapView.leftAnchor, bottom: mapView.bottomAnchor, right: mapView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)


    }
    
    
    
}
















