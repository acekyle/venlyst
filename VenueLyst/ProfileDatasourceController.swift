//
//  ProfileDatasourceController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/10/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit
import LBTAComponents
import SwiftyJSON
import CoreData


class ProfileDatasourceController: DatasourceController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let cellId = "profileCell"
    var currentUser: [User]?

    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    lazy var editButton: UIButton = {
        let eb = UIButton()
        eb.setTitle("Edit", for: .normal)
        eb.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        return eb
    }()
    let editPictureView = UIView.createEmptyViewWithColor(backgroundColor: .white, cornerRadius: 17.5)
    let editPicturebutton: UIButton  = {
        let eb = UIButton()
        eb.setImage(#imageLiteral(resourceName: "edit-picture"), for: .normal)
        eb.addTarget(self, action: #selector(toPhotos), for: .touchUpInside)
        return eb
    }()
    
    var image: UIImage? {
        didSet{
            
            if let selectedImage = image {
                userImageView.image = selectedImage
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavView()
        setupViews()
        
        editPictureView.isHidden = true
        doneButton.isHidden = true

        emailTextView.isEditable = false
        phoneTextView.isEditable = false
        cityTextView.isEditable = false
        
        //Dismiss keyboard
        dismissKeyboardUsingTap(view: self.view)
        
        fetchUserData()
        
        if !(currentUser?.isEmpty)! {
            
            if let user = self.currentUser?[0] {
                
                //MARK: -- FORMAT DATE --
                
//                let timeInt = Double(user.subscribedDate!)
//                let date = NSDate(timeIntervalSince1970: timeInt!)
//                let formatter = DateFormatter()
//                formatter.dateStyle = DateFormatter.Style.short
//                let getDate = formatter.string(from: date as Date)
                
                let userTimeArray = user.subscribedDate?.components(separatedBy: " ")
                
                print("User time:" , user.subscribedDate)
                print("userTime arry:", userTimeArray)
                
                
                self.userImageView.loadImage(urlString: user.profilePic!)
                self.subscribedLabel.text = "Member since \(userTimeArray?[0] ?? "")"
                self.nameLabel.text = user.name
                self.emailTextView.text = user.email
                self.phoneTextView.text = user.phone
                self.cityTextView.text = "\(user.city ?? "")"

            }
        }
    }

    // Create instances
    
    let topProfileView: UIView = {
        let v = UIView()
        v.backgroundColor = .bluVenyard
        return v
    }()
    
    let bottomProfileView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let userImageView: CachedImageView = {
        let imgView = CachedImageView()
        imgView.backgroundColor = .white
        imgView.layer.cornerRadius = 62.5
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.masksToBounds = true
        imgView.layer.shadowColor = UIColor.black.cgColor
        imgView.layer.shadowOpacity = 0.2
        imgView.layer.shadowOffset = CGSize(width: 1, height: 1)
        imgView.layer.shadowRadius = 1
        imgView.clipsToBounds = true
        imgView.image = UIImage()
        return imgView
    }()
    
    let nameLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.textAlignment = .center
        lab.font = UIFont(name: "Lato-Regular", size: 14)
        return lab
    }()
    
    let subscribedLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.textAlignment = .center
        lab.font = UIFont(name: "Lato-Light", size: 14)
        return lab
    }()
    
    let emailLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Email Address"
        lab.textColor = .gray
        lab.textAlignment = .left
        //        lab.backgroundColor = .red
        lab.font = UIFont(name: "Lato-Light", size: 14)
        return lab
    }()
    
    let phoneLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Phone Number"
        lab.textColor = .gray
        lab.textAlignment = .left
        //        lab.backgroundColor = .purple
        lab.font = UIFont(name: "Lato-Light", size: 14)
        return lab
    }()
    
    let cityLabel: UILabel = {
        let lab = UILabel()
        lab.text = "City/State"
        lab.textColor = .gray
        lab.textAlignment = .left
        //        lab.backgroundColor = .orange
        lab.font = UIFont(name: "Lato-Light", size: 14)
        return lab
    }()
    
    let emailTextView: UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.textAlignment = .right
        tv.textColor = .black
        tv.isScrollEnabled = false
        tv.font = UIFont(name: "Lato-Light", size: 14)
        //        tv.backgroundColor = .green
        return tv
    }()
    
    let phoneTextView: UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.textAlignment = .right
        tv.textColor = .black
        tv.isScrollEnabled = false
        tv.font = UIFont(name: "Lato-Light", size: 14)
        //        tv.backgroundColor = .yellow
        return tv
    }()
    
    lazy var cityTextView: UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.textAlignment = .right
        tv.textColor = .black
        tv.isScrollEnabled = false
        tv.font = UIFont(name: "Lato-Light", size: 14)
        tv.delegate = self as? UITextViewDelegate
        //        tv.backgroundColor = .brown
        return tv
    }()
    
    let doneButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("DONE", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Regular", size: 12)
        butt.layer.cornerRadius = 1
        butt.backgroundColor = .ventageOrange
        butt.addTarget(self, action: #selector(saveEditedProfile), for: .touchUpInside)
        return butt
    }()
    
    let seperatorView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return sv
    }()
    
    let seperatorViewp: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return sv
    }()
    
    let seperatorViewc: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return sv
    }()
    
    
    func fetchUserData() {
        
        let userData: NSFetchRequest<User> = User.fetchRequest()
        do{
            currentUser = try managedObjectContext.fetch(userData)
            
        }catch{ print("Could not load data from database") }
        
    }
    
    func saveEditedProfile() {
        exitEditMode()
    }
    
    func setupConstraints() {
        
        topProfileView.anchor(view.topAnchor, left: view.leftAnchor, bottom: bottomProfileView.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.height / 3.7)
        bottomProfileView.anchor(topProfileView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 0)
        
        userImageView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 125, heightConstant: 125)
        view.addConstraint(NSLayoutConstraint(item: userImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        editPictureView.anchor(nil, left: nil, bottom: userImageView.bottomAnchor, right: userImageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        
        editPicturebutton.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        editPictureView.addConstraints([
                NSLayoutConstraint(item: editPicturebutton, attribute: .centerX, relatedBy: .equal, toItem: editPictureView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: editPicturebutton, attribute: .centerY, relatedBy: .equal, toItem: editPictureView, attribute: .centerY, multiplier: 1, constant: 0)
            ])

        nameLabel.anchor(userImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 7, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        subscribedLabel.anchor(nameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        
        emailLabel.anchor(bottomProfileView.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 13, leftConstant: 15, bottomConstant: 13, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        phoneLabel.anchor(seperatorView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 13, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        cityLabel.anchor(seperatorViewp.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 13, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        emailTextView.anchor(bottomProfileView.topAnchor, left: emailLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 30)
        phoneTextView.anchor(seperatorView.bottomAnchor, left: phoneLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 30)
        cityTextView.anchor(seperatorViewp.bottomAnchor, left: cityLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 30)
        
        seperatorView.anchor(emailLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0.5)
        seperatorViewp.anchor(phoneLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0.5)
        seperatorViewc.anchor(cityLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0.5)
        
        doneButton.anchor(seperatorViewc.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: bottomProfileView.frame.size.height + 150, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 45)
        view.addConstraint(NSLayoutConstraint(item: doneButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
    }
    
    func setupNavView() {
        
        let navbar = self.navigationController?.navigationBar
        
        navbar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navbar?.shadowImage = UIImage()
        navbar?.barTintColor = .bluVenyard
        navbar?.isTranslucent = false

        navbar?.addSubview(editButton)
        editButton.anchor(navbar?.topAnchor, left: nil, bottom: nil, right: navbar?.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
    
    
    func setupViews() {
        
        view.addSubview(topProfileView)
        
        topProfileView.addSubview(userImageView)
        topProfileView.addSubview(nameLabel)
        topProfileView.addSubview(subscribedLabel)
        topProfileView.addSubview(editPictureView)
        
        editPictureView.addSubview(editPicturebutton)
        
        view.addSubview(bottomProfileView)
        
        bottomProfileView.addSubview(emailLabel)
        bottomProfileView.addSubview(phoneLabel)
        bottomProfileView.addSubview(cityLabel)
        
        bottomProfileView.addSubview(emailTextView)
        bottomProfileView.addSubview(phoneTextView)
        bottomProfileView.addSubview(cityTextView)
        
        view.addSubview(seperatorView)
        view.addSubview(seperatorViewp)
        view.addSubview(seperatorViewc)
        
        bottomProfileView.addSubview(doneButton)
        
        setupConstraints()
        
    }
    
    func toPhotos() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                
                self.present(imagePicker, animated: false, completion: nil)
                
            }else {
                
                print("Camera not available")
            }
 
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker, animated: false, completion: nil)
                
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: false, completion: nil)
    }
    
    func editProfile(){
        
        if editPictureView.isHidden {
            enterEditMode()
        }else {
            exitEditMode()
        }
        
    }
    
    func enterEditMode() {
        editPictureView.isHidden = false
        doneButton.isHidden = false
        emailTextView.isEditable = true
        phoneTextView.isEditable = true
        cityTextView.isEditable = true
    }
    
    func exitEditMode() {
        editPictureView.isHidden = true
        doneButton.isHidden = true
        emailTextView.isEditable = false
        phoneTextView.isEditable = false
        cityTextView.isEditable = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImageView.image  = image
        }
        
        self.exitEditMode()
        picker.dismiss(animated: false) {
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false, completion: nil)
    }
    
    
    
}
