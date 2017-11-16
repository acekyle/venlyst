//
//  VenueCell.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/6/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents
import CoreData

class VenueCell: DatasourceCell {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let ct = SearchDatasourceController()
    let coreHelper = CoreStack()
    var currentUser: User?
    var favoritesLiked = [String]()
    
    override var datasourceItem: Any? {
        
        didSet {
            guard let venue = datasourceItem as? Venue else { return }
            
            if let name = venue.name?.uppercased(), let city = venue.city {
                
                var address = city.components(separatedBy: ",")
                
                nameLabel.text = name
                cityStateLabel.text = "\(address[2]), \(address[3])"
                streetLabel.text = "\(address[1])"
                self.tag = Int(venue.id!)!
                
                guard let pics = venue.venueDetailedPic as? [String] else { return }
                venueImageView.loadImage(urlString: pics[0])
                
//                if !(venue.matterportLink?.isEmpty)!{
//                    threeDButton.isHidden = false
//                 }
                
//                if let tempArr = currentUser?.favorites as? [String] {
//                    if tempArr.contains(venue.id!){
//                        favButton.setImage(#imageLiteral(resourceName: "likeButtonFilled"), for: .normal)
//                    }
//                }
            
            }

        }
    }
    
   
        // create instances of views
    
    let venueImageView: CachedImageView = {
        let imgView = CachedImageView()
        imgView.backgroundColor = .white
        imgView.layer.masksToBounds = true
        imgView.image = UIImage()
        return imgView
    }()
    
    let matterportVideo: UIWebView = {
        let webView = UIWebView()
        webView.allowsInlineMediaPlayback = true
        webView.isHidden = true
        return webView
    }()
    
    let cityStateLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.font = UIFont(name: "Lato-Bold", size: 14)
        return lab
    }()
    
    let streetLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.font = UIFont(name: "Lato-Bold", size: 14)
        return lab
    }()
    
    lazy var favButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "likeButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(handleHeartTap), for: .touchUpInside)
        return btn
    }()
    
    let playButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "PlayButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var threeDButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "MatterportButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let nameLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.font = UIFont(name: "Lato-Bold", size: 12)
        return lab
    }()
    
    lazy var linkButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("VIEW DETAILS", for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Regular", size: 12)
        butt.isUserInteractionEnabled = true
        butt.addTarget(self, action: #selector(sendToDetailed), for: .touchUpInside)
        butt.backgroundColor = UIColor.ventageOrange
        return butt
    }()
    

    func sendToDetailed() {
        let stackDetailsController = StackedDetailsView()
        let topVC = getTopViewController()
        let currentId = String(self.tag)
 
        if let venue = coreHelper.fetchVenueDataById(id: currentId)?[0] {
            stackDetailsController.venueObject = venue
        }
        
        guard let user = coreHelper.fetchUserData() else { return }
        
        if user.count > 0 {
            currentUser = user[0]
            var currentRecentsArray = currentUser?.value(forKey: "recentVenues") as! [String]
            
            if !currentRecentsArray.contains(currentId) {
                if currentRecentsArray.count > 2 {
                    currentRecentsArray.removeFirst()
                }
                
                currentRecentsArray.append(currentId)
                coreHelper.updateUserRecentVenues(value: currentRecentsArray)
            }else{}
            
            guard let updatedUser = coreHelper.fetchUserData()?[0] else { return }
            currentUser = updatedUser
        }
   
        // MARK: -- UPDATE USER FAVORITES IN CORE DATA --
                
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadRecents"), object: nil)
        topVC?.present(stackDetailsController, animated: false, completion: nil)

    }
    
    func setupConstraints() {
        
        // place constraints on the views and call this function -- DONT FORGET
        venueImageView.anchor(topAnchor, left: leftAnchor, bottom: nameLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        matterportVideo.anchor(topAnchor, left: leftAnchor, bottom: nameLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        nameLabel.anchor(venueImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: linkButton.leftAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        linkButton.anchor(venueImageView.bottomAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.width / 4, heightConstant: 0)
        cityStateLabel.anchor(nil, left: leftAnchor, bottom: streetLabel.topAnchor, right: threeDButton.leftAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 3, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        streetLabel.anchor(nil, left: leftAnchor, bottom: nameLabel.topAnchor, right: threeDButton.leftAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//        favButton.anchor(venueImageView.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: frame.width / 9, heightConstant: frame.height / 6)
//        playButton.anchor(nil, left: nil, bottom: nameLabel.topAnchor, right: threeDButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: frame.width / 9, heightConstant: venueImageView.frame.height / 6)
        threeDButton.anchor(nil, left: nil, bottom: nameLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: frame.width / 9, heightConstant: venueImageView.frame.height / 6)
    }
    
    override func setupViews() {
        super.setupViews()
        
        // addSubViews
        
        addSubview(venueImageView)
        addSubview(nameLabel)
        addSubview(linkButton)
        addSubview(matterportVideo)

        venueImageView.addSubview(cityStateLabel)
        venueImageView.addSubview(streetLabel)
        venueImageView.addSubview(playButton)
   
        addSubview(favButton)
        addSubview(threeDButton)
        
        setupConstraints()
        
    
//        threeDButton.isHidden = true
    }
    
    
    func handleHeartTap(){
        
        let currentVenueId: Int? = self.tag
        guard let user = coreHelper.fetchUserData() else { return }
        
        if user.count > 0 {
            currentUser = user[0]
        
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
    }
    
}

