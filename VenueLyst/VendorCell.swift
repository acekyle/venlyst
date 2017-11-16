//
//  VendorCell.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/9/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents

class VendorCell: DatasourceCell {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let ct = SearchDatasourceController()
    let coreHelper = CoreStack()
    var currentUser: User?

    override var datasourceItem: Any? {
        didSet {
            guard let vendor = datasourceItem as? Vendor else { return }
            
            if let name = vendor.name?.uppercased(), let specialize = vendor.specialization, let experience = vendor.experience, let career = vendor.vendorType {
                
                nameLabel.text = name
                experienceLabel.text = "Experience: \(experience)"
                careerLabel.text = career
                specializeLabel.text = "Specialization: \(specialize)"
                self.tag = Int(vendor.id!)!
                
                
                guard let pics = vendor.vendorDetailedPic as? [String] else { return }
                vendorImageView.loadImage(urlString: pics[0])
                
            }
        }
    }
    
    
    let vendorImageView: CachedImageView = {
        let imgView = CachedImageView()
        imgView.backgroundColor = .white
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage()
        return imgView
    }()
    
    let experienceLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.font = UIFont(name: "Lato-Regular", size: 14)
        return lab
    }()
    
    let specializeLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.font = UIFont(name: "Lato-Regular", size: 14)
        return lab
    }()
    
    let careerLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.font = UIFont(name: "Lato-Regular", size: 14)
        return lab
    }()
    
    let favButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "likeButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let nameLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .black
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
        
        let vendorDetailsController = VendorDetailsController()
        let topVC = getTopViewController()
        let currentId = String(self.tag)
        
        if let vendor = coreHelper.fetchVendorDataById(id: currentId)?[0] {
            vendorDetailsController.vendorObject = vendor
        }
        
        guard let user = coreHelper.fetchUserData() else { return }
        
        if user.count > 0 {
         
            currentUser = user[0]
            var currentRecentsArray = currentUser?.value(forKey: "recentVendors") as! [String]
            
            if !currentRecentsArray.contains(currentId) {
                if currentRecentsArray.count > 2 {
                    currentRecentsArray.removeFirst()
                }
                
                currentRecentsArray.append(currentId)
                coreHelper.updateUserRecentVendors(value: currentRecentsArray)
            }else{}
            
            // MARK: -- UPDATE USER FAVORITES IN CORE DATA --
            
            guard let updatedUser = coreHelper.fetchUserData()?[0] else { return }
            currentUser = updatedUser
            
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadRecents"), object: nil)
        topVC?.present(vendorDetailsController, animated: false, completion: nil)
        
    }
    
    func setupConstraints() {
        
        // place constraints on the views and call this function -- DONT FORGET
        vendorImageView.anchor(topAnchor, left: leftAnchor, bottom: nameLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        nameLabel.anchor(vendorImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: linkButton.leftAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        linkButton.anchor(vendorImageView.bottomAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.width / 4, heightConstant: 0)
        careerLabel.anchor(nil, left: leftAnchor, bottom: experienceLabel.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 3, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        experienceLabel.anchor(nil, left: leftAnchor, bottom: specializeLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 3, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        specializeLabel.anchor(nil, left: leftAnchor, bottom: nameLabel.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//        favButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: frame.width / 9, heightConstant: vendorImageView.frame.height / 6)
       
    }
    
    override func setupViews() {
        super.setupViews()
        
        // addSubViews
        
        addSubview(vendorImageView)
        addSubview(nameLabel)
        addSubview(linkButton)
        
        vendorImageView.addSubview(careerLabel)
        vendorImageView.addSubview(experienceLabel)
        vendorImageView.addSubview(specializeLabel)
        
//        vendorImageView.addSubview(favButton)
        
        setupConstraints()
        
    }
    
    
    
}
