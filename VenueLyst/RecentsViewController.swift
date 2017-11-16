//
//  RecentsViewController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/23/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit
import LBTAComponents
import CoreData

class RecentsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    ///
    //                   ---    RELOAD COLLECTIONVIEW AFTER FETCHING   ---
    ///

    let recentVenuesCategoryCellId = "recentCell"
    let recentVendorsCategoryCellId =  "recentOtherCell"
    
    
    var recentVenues = [Venue]()
    var recentVendors = [Vendor]()
    var recentCategories: [RecentCategory]?
    
    var currentUser: User?
    let coreHelper = CoreStack()
    let userHelper = CoreUserStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        if let userCheck = coreHelper.fetchUserData() {
            
            let recentVenuesCategory = RecentCategory()
            recentVenuesCategory.name = "  Recent Venues"
            
            let recentVendorCategory = RecentCategory()
            recentVendorCategory.name = "  Recent Vendors"
            
            if userCheck.count > 0 {
                print("Grabbing user from core data")
                currentUser = userCheck[0]
                
                recentVenues = self.coreHelper.fetchVenueDataByIds(ids: currentUser?.recentVenues as! [String])!
                recentVendors = self.coreHelper.fetchVendorsDataByIds(ids: currentUser?.recentVendors as! [String])!
                
                
                recentVenuesCategory.recentVenues = self.recentVenues
                recentVendorCategory.recentVendors = self.recentVendors
                
                recentCategories = [recentVenuesCategory, recentVendorCategory]
                recentCategoryCollection.reloadData()
            }else{
                
                let email = userHelper.getEmail()
                let password = userHelper.getKey()!
                
                Service.sharedInstance.fetchHomeControllerData(email: email, password: password, completion: { (HomeDatasource) in
                    
                    print("Homedatasource from recents: ", HomeDatasource.users)
                    
                    self.coreHelper.clearUserData()
                    self.coreHelper.saveUserToCoreData(userArray: HomeDatasource.users)
                    self.recentCategoryCollection.reloadData()
                    
                    
                })

                recentVenuesCategory.recentVenues = self.recentVenues
                recentVendorCategory.recentVendors = self.recentVendors
                
                recentCategories = [recentVenuesCategory, recentVendorCategory]
                recentCategoryCollection.reloadData()
            
            }
            
            self.welcomeLabel.text = "Welcome, \(self.currentUser?.name! ?? "Guest")"
            
        }else{
            print("Couldnt get user data from core data")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        recentCategoryCollection.reloadData()
    }

    let welcomeView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let welcomeLabel = UILabel.createLabel(text: "Welcome, ", size: 36, textColor: .blue, fontType: "Regular", alignment: .left)
    let welcomeDescription = UILabel.createLabel(text: "Let's find the right spot for you", size: 14, textColor: .gray, fontType: "Light", alignment: .left)
 
    lazy var recentCategoryCollection: UICollectionView = {
        let cv = UICollectionView.createCollectionView()
        cv.delegate = self
        cv.dataSource = self
        cv.register(RecentVenuesCategoryCell.self, forCellWithReuseIdentifier: self.recentVenuesCategoryCellId)
        cv.register(RecentVendorsCategoryCell.self, forCellWithReuseIdentifier: self.recentVendorsCategoryCellId)
        return cv
    }()
    
    func setupViews(){
        
        view.addSubview(welcomeView)
        welcomeView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: view.frame.height / 6 - 5)
        
        welcomeView.addSubview(welcomeLabel)
        welcomeView.addSubview(welcomeDescription)
        
        welcomeLabel.anchor(welcomeView.topAnchor, left: welcomeView.leftAnchor, bottom: nil, right: welcomeView.rightAnchor, topConstant: 35, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 45)
        welcomeDescription.anchor(welcomeLabel.bottomAnchor, left: welcomeView.leftAnchor, bottom: welcomeView.bottomAnchor, right: welcomeView.rightAnchor, topConstant: 0, leftConstant: 13, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  
        view.addSubview(recentCategoryCollection)
        recentCategoryCollection.anchor(welcomeView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = recentCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recentVenuesCategoryCellId, for: indexPath) as! RecentVenuesCategoryCell
            cell.backgroundColor = .white
            cell.RecentCategoryData = recentCategories?[indexPath.item]
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recentVendorsCategoryCellId, for: indexPath) as! RecentVendorsCategoryCell
            cell.backgroundColor = .white
            cell.RecentCategoryData = recentCategories?[indexPath.item]
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (UIScreen.main.bounds.height - (view.frame.height / 6 + 75)) / 2 )
    }

}

class RecentCategoryCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentUser: User?
    let coreHelper = CoreStack()
    
    let vendorCellId = "recentVendorCategoryCell"
    let venueCellId = "recentVenuesCategoryCell"
    let nonActiveCellId = "recentNonActiveCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(updateRecentsCollection), name:NSNotification.Name(rawValue: "loadRecents"), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var RecentCategoryData: RecentCategory? {
        didSet {
            
            if let name = RecentCategoryData?.name {
                
                titleLabel.text = name
            }
        }
    }
    
    let titleLabel = UILabel.createLabel(text: "  Recent Venues", size: 22, textColor: .orange, fontType: "Light", backgroundColor: .white, alignment: .left)
    lazy var recentsCollectionView: UICollectionView = {
        let cv = UICollectionView.createCollectionView(direction: .horizontal)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    func updateRecentsCollection(notification: Notification){
        currentUser = coreHelper.fetchUserData()?[0]
        if currentUser != nil {
            guard let recentVenues = coreHelper.fetchVenueDataByIds(ids: currentUser?.recentVenues as! [String]) else { return }
            guard let recentVendors = coreHelper.fetchVendorsDataByIds(ids: currentUser?.recentVendors as! [String]) else { return }
            self.RecentCategoryData?.recentVenues = recentVenues
            self.RecentCategoryData?.recentVendors = recentVendors
            recentsCollectionView.reloadData()
        }
    }
    
    func setupViews(){
        
        addSubview(titleLabel)
        addSubview(recentsCollectionView)
        titleLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        recentsCollectionView.anchor(titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width , heightConstant: frame.height - 40)
        
        recentsCollectionView.register(VendorCell.self, forCellWithReuseIdentifier: vendorCellId)
        recentsCollectionView.register(VenueCell.self, forCellWithReuseIdentifier: venueCellId)
        recentsCollectionView.register(NoActivityCell.self, forCellWithReuseIdentifier: nonActiveCellId)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as UICollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class RecentVendorsCategoryCell: RecentCategoryCell {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = RecentCategoryData?.recentVendors?.count {
            if count > 0 {
                return count
            }else{
                return 1
            }
            
        }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let count = RecentCategoryData?.recentVendors?.count {
            if count > 0 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: vendorCellId, for: indexPath) as! VendorCell
                let vendor = RecentCategoryData?.recentVendors?[indexPath.item]
                
                cell.datasourceItem = vendor
                
//                if let pic = vendor?.vendorThumbPic, let name = vendor?.name?.uppercased(), let experience = vendor?.experience, let specialize = vendor?.specialization {
//                    cell.vendorImageView.loadImage(urlString: pic)
//                    cell.nameLabel.text = name
//                    cell.experienceLabel.text = "Experience: \(experience) years"
//                    cell.careerLabel.text = career
//                    cell.specializeLabel.text = "Specialization: \(specialize)"
////                    cell.tag = Int((vendor?.id)!)
//                }
                return cell
                
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nonActiveCellId, for: indexPath) as! NoActivityCell
                cell.noActivityLabel.text = "No Recent Vendors"
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    
}

class RecentVenuesCategoryCell: RecentCategoryCell {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = RecentCategoryData?.recentVenues?.count {
            if count > 0 {
                
                return count
            
            }else{ return 1 }
        }
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let count = RecentCategoryData?.recentVenues?.count {
            if count > 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: venueCellId, for: indexPath) as! VenueCell
                let venue = RecentCategoryData?.recentVenues?[indexPath.item]
                
                cell.datasourceItem = venue
                
//                if let pic =  venue?.venueThumbPic, let name = venue?.name?.uppercased(), let city = venue?.city, let state = venue?.state, let street = venue?.street {
//                    cell.venueImageView.loadImage(urlString: pic)
//                    cell.nameLabel.text = name
//                    cell.cityStateLabel.text = "\(city), \(state)"
//                    cell.streetLabel.text = street
//                    cell.tag = Int((venue?.id)!)
//                }
                
                return cell
            
            }else{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nonActiveCellId, for: indexPath) as! NoActivityCell
                cell.noActivityLabel.text = "No Recent Venues"
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    
}









