//
//  FavoriteVenuesCell.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/30/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents

class FavoriteVenuesCell: DatasourceCell {
    
    private let cellId = "recentFavs"
    let coreHelper = CoreStack()
    var currentUser: User?
    var homeController: FavoritesDatasourceController?

    // Change Recent Category to Favorites category
    
    var favoriteVenue: Venue? {
        didSet {
//        guard let recent = datasourceItem as? FavoriteCategory else { return }
            
            if let name = favoriteVenue?.name, let type = favoriteVenue?.venueType, let venueId = favoriteVenue?.id {
                titleLabel.text = "  \(name)"
                subTitleLabel.text = "   \(type)"
                favButton.tag = Int(venueId)!
                
                guard let pics = favoriteVenue?.venueDetailedPic as? [String] else { return }
                favVenueImageView.loadImage(urlString: pics[0])
            }
        }
    }
    
    // create instances of views
    
    let favVenueImageView: CachedImageView = {
        let imgView = CachedImageView()
        imgView.backgroundColor = .white
        imgView.layer.masksToBounds = true
        imgView.image = UIImage()
        return imgView
    }()
    
    let blurredImage: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.23)
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        imgView.image = UIImage()
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let lab = UILabel()
        lab.text = "  Favorite Venues"
        lab.textColor = .black
        lab.backgroundColor = .white
        lab.font = UIFont(name: "Lato-Regular", size: 18)
        return lab
    }()
    
    let subTitleLabel: UILabel = {
        let lab = UILabel()
        lab.text = "  2 Resturants"
        lab.textColor = .gray
        lab.backgroundColor = .white
        lab.font = UIFont(name: "Lato-Light", size: 14)
        return lab
    }()
    
    lazy var favButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "likeButtonFilled"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(handleHeartTap), for: .touchUpInside)
        return btn
    }()
    
    func checkIfLiked(button: UIButton){
        guard let user = coreHelper.fetchUserData()?[0] else { return }
        currentUser = user
        
        let currentfavs = currentUser?.favorites as! [String]
        
        print(currentfavs.count)
        
        let currentId = String(button.tag)
        if currentfavs.contains(currentId){
            print("Included in the favs")
            
        }
    }
    
    func handleHeartTap(_ button: UIButton){
        
        if (favButton.currentImage?.isEqual(#imageLiteral(resourceName: "likeButton")))! {
            favButton.setImage(#imageLiteral(resourceName: "likeButtonFilled"), for: .normal)

        }else{
            favButton.setImage(#imageLiteral(resourceName: "likeButton"), for: .normal)
            guard let user = coreHelper.fetchUserData()?[0] else { return }
            currentUser = user
            
            if currentUser?.value(forKey: "favorites") != nil {
                var currentFavoritesArray = currentUser?.value(forKey: "favorites") as! [String]
                let currentId = String(describing: button.tag)
                
                currentFavoritesArray = currentFavoritesArray.filter { $0 != currentId }
                coreHelper.updateUserFavorites(value: currentFavoritesArray)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
            }
        }
    }
    
    func setupConstraints() {
        
        favVenueImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: frame.height - 50)
        blurredImage.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: frame.height - 50)
        titleLabel.anchor(favVenueImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        subTitleLabel.anchor(titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        favButton.anchor(favVenueImageView.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: frame.width / 10, heightConstant: frame.height / 9.5)
  
    }
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(favVenueImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(blurredImage)
        addSubview(favButton)
        
        setupConstraints()
        
    }
    

    
}

