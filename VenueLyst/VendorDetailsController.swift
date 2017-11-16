//
//  VendorDetailsController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/11/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents

class VendorDetailsController: UIViewController {
    
    var currentVenueId: Int?
    var currentPicture = 0
    var currentUser: User?
    var pictureArray = [String]()
    
    var vendorObject: Vendor? {
        didSet {
    
            guard let vendor = vendorObject else { return }
            
            currentVenueId = Int(vendor.id!)
            
            if let vendorPictures = vendor.vendorDetailedPic as? [String] {
                vendorDetailedPic.loadImage(urlString: vendorPictures[0], completion: {
                    self.pictureArray = vendorPictures
                })
            }
            
            vendorName.text = vendor.name
            vendorCareer.text = vendor.vendorType
            vendorExperience.text = "Experience: \(vendor.experience ?? "")"
            vendorSpecialty.text = "Specialty: \(vendor.specialization ?? "")"
            vendorRate.text = vendor.vendorRate

            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5
            let attributes = [NSParagraphStyleAttributeName : style, NSFontAttributeName:UIFont(name: "Lato-Light", size: 14.0)!]
            vendorDescription.attributedText = NSAttributedString(string: vendor.vendorDescription!, attributes: attributes)

//            if vendor.fbLink != nil {
//                let fbAccountLink = vendor.fbLink
//            }
//            if vendor.twitLink != nil {
//                let twitAccountLink = vendor.twitLink
//            }
//            if vendor.instaLink != nil {
//                let instaAccountLink = vendor.instaLink
//            }
            
            guard let vendorPhone = Int(vendor.vendorContact!) else { return }
            contactButton.tag = vendorPhone
            
            
//            if vendor.vendorContact != nil {
//                if let vendorPhoneNumber = vendor.vendorContact {
//                    let intNumber = Int(vendorPhoneNumber)
//                    contactButton.tag = intNumber!
//                }
//            }
//            contactButton.tag = Int(vendor.vendorContact!)!
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        view.backgroundColor = .white
        
        nextPicButton.isHidden = true
        if pictureArray.count > 1 {
            self.nextPicButton.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) { UIApplication.shared.statusBarStyle = .lightContent }
    
    let topNavView = UIView.createEmptyViewWithColor(backgroundColor: UIColor.bluVenyard)
    let vendorTitle = UILabel.createLabel(text: "Vendor Details", size: 18, fontType: "Bold")
    let vendorDetailedPic = CachedImageView.createImageWith(imageOf: UIImage(), contentMode: .scaleAspectFill, backgroundColor: .lightGray)
    let vendorName = UILabel.createLabel(text: "James Harden", size: 18, textColor: .black, fontType: "Bold")
    let vendorRate = UILabel.createLabel(text: "$155", size: 16, textColor: .black, fontType: "Bold")
    let vendorRateHr = UILabel.createLabel(text: "/hr", size: 14, textColor: .black, fontType: "Bold")
    let vendorCareer = UILabel.createLabel(text: "Music / DJ", size: 14, textColor: .ventageOrange, fontType: "Light")
    let vendorExperience = UILabel.createLabel(text: "Experience: 5 years", size: 14, textColor: .black, fontType: "Light")
    let vendorSpecialty = UILabel.createLabel(text: "Specialty: Bars, Concerts", size: 14, textColor: .black, fontType: "Light")
    let vendorDescription: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.text = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text."
        tv.textColor = .black
        tv.font = UIFont(name: "Lato-Light", size: 14)
        return tv
    }()
    let socialView = UIView.createEmptyViewWithColor(backgroundColor: .clear)
    
    func handleSocialButton(_ :UIButton) {
        
    }
    
    lazy var fbButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "Facebook"), for: .normal)
        butt.imageView?.contentMode = .scaleAspectFit
        butt.addTarget(self, action: #selector(handleSocialButton), for: .touchUpInside)
        butt.tag = 2
        return butt
    }()
    
    lazy var tweetButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "Twitter"), for: .normal)
        butt.imageView?.contentMode = .scaleAspectFit
        butt.addTarget(self, action: #selector(handleSocialButton), for: .touchUpInside)
        butt.tag = 3
        return butt
    }()
    
    lazy var instaButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "Instagram"), for: .normal)
        butt.imageView?.contentMode = .scaleAspectFit
        butt.addTarget(self, action: #selector(handleSocialButton), for: .touchUpInside)
        butt.tag = 4
        return butt
    }()
    lazy var contactButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("CONTACT THIS VENDOR", for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Bold", size: 14)
        butt.backgroundColor = UIColor.ventageOrange
        butt.addTarget(self, action: #selector(handleContactButtonPressed), for: .touchUpInside)
        return butt
    }()
    
    func handleContactButtonPressed() {
        makeCall(phone: "\(contactButton.tag)")
    }
    
    func makeCall(phone: String) {
        
        if phone.count < 10 {
            let alert = UIAlertController(title: "Vendor Info", message: "Vendor hasn't set up contacts yet", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }else{
            let number = phone.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
            let phoneUrl = "tel://\(number)"
            let url:NSURL = NSURL(string: phoneUrl)!
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        
    }
    
    let backButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "left-chevron"), for: .normal)
        butt.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return butt
    }()
    
    func goBack(){
        self.dismiss(animated: false) {}
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
        vendorDetailedPic.loadImage(urlString: pictureArray[currentPicture])
    }
    
    
    func setupViews() {
    
        topNavView.addSubview(vendorTitle)
        topNavView.addSubview(backButton)
        view.addSubview(topNavView)
        view.addSubview(vendorDetailedPic)
        view.addSubview(vendorName)
        view.addSubview(vendorCareer)
        view.addSubview(vendorExperience)
        view.addSubview(vendorSpecialty)
        view.addSubview(vendorRate)
        view.addSubview(vendorRateHr)
        view.addSubview(vendorDescription)
        view.addSubview(socialView)
        view.addSubview(fbButton)
        view.addSubview(tweetButton)
        view.addSubview(instaButton)
        view.addSubview(contactButton)
        view.addSubview(nextPicButton)
        
        topNavView.anchor(view.topAnchor, left: view.leftAnchor, bottom: vendorDetailedPic.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: view.frame.height / 11)
        backButton.anchor(nil, left: view.leftAnchor, bottom: topNavView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 24, heightConstant: 24)
        vendorTitle.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addConstraints([
                NSLayoutConstraint(item: vendorTitle, attribute: .centerX, relatedBy: .equal, toItem: topNavView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vendorTitle, attribute: .centerY, relatedBy: .equal, toItem: topNavView, attribute: .centerY, multiplier: 1, constant: 7)
            ])
        
        nextPicButton.anchor(topNavView.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: (view.frame.height / 2.7) / 1.5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 48, heightConstant: 48)
        
        vendorDetailedPic.anchor(topNavView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: view.frame.height / 2.7)
        vendorName.anchor(vendorDetailedPic.bottomAnchor, left: view.leftAnchor, bottom: vendorCareer.topAnchor, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        vendorRate.anchor(vendorDetailedPic.bottomAnchor, left: nil, bottom: vendorCareer.topAnchor, right: vendorRateHr.leftAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        vendorRateHr.anchor(vendorDetailedPic.bottomAnchor, left: vendorRate.rightAnchor, bottom: vendorCareer.topAnchor, right: view.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        vendorCareer.anchor(vendorName.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        vendorExperience.anchor(vendorCareer.bottomAnchor, left: view.leftAnchor, bottom: vendorSpecialty.topAnchor, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        vendorSpecialty.anchor(vendorExperience.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vendorDescription.anchor(vendorSpecialty.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: view.frame.height / 7)
        socialView.anchor(vendorDescription.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: view.frame.height / 20)
        
        instaButton.anchor(socialView.topAnchor, left: tweetButton.rightAnchor, bottom: socialView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 9, heightConstant: 0)
        tweetButton.anchor(socialView.topAnchor, left: nil, bottom: socialView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 9, heightConstant: 0)
        fbButton.anchor(socialView.topAnchor, left: nil, bottom: socialView.bottomAnchor, right: tweetButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 9, heightConstant: 0)
        view.addConstraint(NSLayoutConstraint(item: tweetButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        contactButton.anchor(socialView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 1.3, heightConstant: view.frame.height / 13)
        view.addConstraint(NSLayoutConstraint(item: contactButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
    }
    
    
}
