//
//  MapVenuePopUpCell.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/9/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents

class MapPopupCell: DatasourceCell {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let ct = SearchDatasourceController()
    let coreHelper = CoreStack()
    var currentUser: User?
    
    override var datasourceItem: Any? {
        didSet {
            guard let venue = datasourceItem as? Venue else { return }
            
            // pass information to indivdual variables
            if let name = venue.name?.uppercased(), let city = venue.city {
                
                var address = city.components(separatedBy: ",")
                                
                nameLabel.text = name
                cityStateLabel.text = "\(address[2]), \(address[3])"
                streetLabel.text = "\(address[1])"
                shortDescription.text = venue.venueDescription
                self.tag = Int(venue.id!)!
                
                guard let pics = venue.venueDetailedPic as? [String] else { return }
                venueImageView.loadImage(urlString: pics[0])
                
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
    
    let shortDescription: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .white
        tv.textColor = .gray
        tv.textAlignment = .left
        tv.allowsEditingTextAttributes = false
        tv.text = "Hello my name is Aaron and I like long walks on the beach. Besides the beach, I love to code swift! "
        return tv
    }()
    
    let cityStateLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.font = UIFont(name: "Lato-Bold", size: 14)
        //        lab.backgroundColor = .red
        return lab
    }()
    
    let streetLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.font = UIFont(name: "Lato-Regular", size: 14)
        //        lab.backgroundColor = .gray
        return lab
    }()
    
    let favButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "share-symbol"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let playButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "PlayButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let threeDButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "MatterportButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let nameLabel: UILabel = {
        let lab = UILabel()
        lab.text = "$510 - $750/hr"
        lab.font = UIFont(name: "Lato-Bold", size: 14)
        return lab
    }()
    
    lazy var linkButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("VIEW VENUE DETAILS", for: .normal)
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
        
        guard let user = coreHelper.fetchUserData()?[0] else { return }
        currentUser = user
        var currentRecentsArray = currentUser?.value(forKey: "recentVenues") as! [String]
        
        if !currentRecentsArray.contains(currentId) {
            if currentRecentsArray.count > 4 {
                currentRecentsArray.removeFirst()
            }
            
            currentRecentsArray.append(currentId)
            coreHelper.updateUserRecentVenues(value: currentRecentsArray)
        }else{}
        
        // MARK: -- UPDATE USER FAVORITES IN CORE DATA --
        
        guard let updatedUser = coreHelper.fetchUserData()?[0] else { return }
        currentUser = updatedUser
        
        topVC?.present(stackDetailsController, animated: false, completion: nil)
    }
    
    func setupConstraints() {
        
        // place constraints on the views and call this function -- DONT FORGET
        venueImageView.anchor(topAnchor, left: leftAnchor, bottom: nameLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: frame.height / 2.5)
        nameLabel.anchor(venueImageView.bottomAnchor, left: leftAnchor, bottom: shortDescription.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: frame.height / 20)
        shortDescription.anchor(nameLabel.bottomAnchor, left: leftAnchor, bottom: linkButton.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 5, rightConstant: 25, widthConstant: 0, heightConstant: frame.height / 9)
        linkButton.anchor(shortDescription.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        cityStateLabel.anchor(nil, left: leftAnchor, bottom: streetLabel.topAnchor, right: threeDButton.leftAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 3, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        streetLabel.anchor(nil, left: leftAnchor, bottom: nameLabel.topAnchor, right: threeDButton.leftAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        favButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: frame.width / 10, heightConstant: venueImageView.frame.height / 13)
//        playButton.anchor(nil, left: nil, bottom: nameLabel.topAnchor, right: threeDButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: frame.width / 9, heightConstant: venueImageView.frame.height / 13)
        threeDButton.anchor(nil, left: nil, bottom: nameLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: frame.width / 9, heightConstant: venueImageView.frame.height / 13)
    }
    
    
    override func setupViews() {
        super.setupViews()
        
        // addSubViews
        
        addSubview(venueImageView)
        addSubview(nameLabel)
        addSubview(linkButton)
        addSubview(shortDescription)
        
        venueImageView.addSubview(cityStateLabel)
        venueImageView.addSubview(streetLabel)
        
        venueImageView.addSubview(favButton)
        venueImageView.addSubview(playButton)
        venueImageView.addSubview(threeDButton)
        
        setupConstraints()
        
    }
    
    
}
