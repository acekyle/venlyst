//
//  EditVendorsFilter.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 10/4/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit

class EditVendorsFilterController: UIViewController,  UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    enum VendorTypeCategories {
        case catering
        case dj
        case florist
        case eventplanners
        case baker
    }
    
    enum VendorRatesCategories {
        case onehundred
        case twohundred
        case threehundred
        case fourhundred
        case fivehundred
        case custom
    }
 
    //--MARK: MAIN LAYOUT
    
    let refineLabel = UILabel.createLabel(text: "REFINE YOUR SEARCH", size: 16, textColor: .black, fontType: "Bold", backgroundColor: .clear, alignment: .left)
    let vendorTypeLabel = UILabel.createLabel(text: "VENDOR TYPES", size: 16, textColor: .black, fontType: "Bold", backgroundColor: .clear, alignment: .left)
    let vendorRatesLabel = UILabel.createLabel(text: "VENDOR RATES", size: 16, textColor: .black, fontType: "Bold", backgroundColor: .clear, alignment: .left)
    
    let refineLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let vendorTypeLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let vendorRatesView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    
    let refineObjectsView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let vendorTypeObjectsView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let vendorRatesObjectsView = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let doneButtonView = UIView.createEmptyViewWithColor(backgroundColor: .bluVenyard)
    
    let vendorTypeViewLeft = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let vendorTypeViewRight = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let vendorRatesViewLeft = UIView.createEmptyViewWithColor(backgroundColor: .white)
    let vendorRatesViewRight = UIView.createEmptyViewWithColor(backgroundColor: .white)

    
    //-- MARK: SUB-VIEWS TO MAIN LAYOUT
    
    let cateringLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let djLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let floristLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let eventPlannerLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let bakerLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)

    let oneHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let twoHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let threeHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let fourHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let fiveHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)
    let fivePlusHundredLabelView = UIView.createEmptyViewWithColor(backgroundColor: .white, borderWidth: 2, borderColor: UIColor.bluVenyard.cgColor, cornerRadius: 5)

    
    //--MARK: SUBVIEWS LABELS
    
    let cateringLabel = UILabel.createLabel(text: "Catering", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let djLabel = UILabel.createLabel(text: "DJ", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let floristLabel = UILabel.createLabel(text: "Florist", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let eventPlannerLabel = UILabel.createLabel(text: "Event Planner", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let bakerLabel = UILabel.createLabel(text: "Baker", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    
    let oneHundredLabel = UILabel.createLabel(text: "$100", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let twoHundredLabel = UILabel.createLabel(text: "$200", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let threeHundredLabel = UILabel.createLabel(text: "$300", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let fourHundredLabel = UILabel.createLabel(text: "$400", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let fiveHundredLabel = UILabel.createLabel(text: "$500", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    let fiveHundredPlusLabel = UILabel.createLabel(text: "Custom", size: 14, textColor: .black, fontType: "Regular", backgroundColor: .clear, alignment: .left)
    
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
        let tabBarController = CustomTabBarController()
        tabBarController.selectedIndex = 1
        present(tabBarController, animated: false, completion: nil)
    }
    
    
    func handleTappedFilterButton(button: UIButton) {
        let selectedAssociatedValue = button.tag
        let v = view.viewWithTag(selectedAssociatedValue)
        let categoryLabels: [UILabel] = [cateringLabel, djLabel, floristLabel, eventPlannerLabel, bakerLabel, oneHundredLabel, threeHundredLabel, fiveHundredLabel, twoHundredLabel, fourHundredLabel, fiveHundredPlusLabel]
        
        if v?.backgroundColor !=  .bluVenyard {
            v?.backgroundColor = .bluVenyard
            categoryLabels[selectedAssociatedValue - 1].textColor = .white
        }else{
            v?.backgroundColor = .white
            categoryLabels[selectedAssociatedValue - 1].textColor = .black
        }
        
    }
    
    func setupViews() {
        let categoryViews: [UIView] = [cateringLabelView, djLabelView, floristLabelView, eventPlannerLabelView, bakerLabelView, oneHundredLabelView, threeHundredLabelView, fiveHundredLabelView, twoHundredLabelView, fourHundredLabelView, fivePlusHundredLabelView]
        
        
        let rstraintObjects = UIScreen.main.bounds.height / 5
        let rstraintLabel = UIScreen.main.bounds.height / 15
        let doneButtonConstriant = rstraintLabel + 15
        let scrollHeight: CGFloat = (rstraintObjects * 5) + (rstraintLabel * 6) + doneButtonConstriant
        
        let stackViews: [UIView] = [refineLabelView, refineObjectsView, vendorTypeLabelView, vendorTypeObjectsView, vendorRatesView, vendorRatesObjectsView, doneButtonView]
        
        let mainStackView = UIStackView.createStackView(views: stackViews, axis: .vertical, distribution: .fill)
        let venueStackView = UIStackView.createStackView(views: [vendorTypeViewLeft, vendorTypeViewRight], axis: .horizontal)
        let guestsStackView = UIStackView.createStackView(views: [vendorRatesViewLeft, vendorRatesViewRight], axis: .horizontal)

        
        let venueCategoryStackLeft = UIStackView.createStackView(views: [cateringLabelView, djLabelView, floristLabelView], spacing: 10)
        let venueCategoryStackRight = UIStackView.createStackView(views: [eventPlannerLabelView, bakerLabelView, UIView()], spacing: 10)
        let guestsCategoryStackLeft = UIStackView.createStackView(views: [oneHundredLabelView, threeHundredLabelView, fiveHundredLabelView], spacing: 10)
        let guestsCategoryStackRight = UIStackView.createStackView(views: [twoHundredLabelView, fourHundredLabelView, fivePlusHundredLabelView], spacing: 10)

        
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
        
//        let locationTextView: UITextField = {
//            let tv = UITextField()
//            tv.placeholder = "       Houston, TX"
//            tv.textAlignment = .left
//            tv.textColor = .black
//            tv.font = UIFont(name: "Lato-Bold", size: 14)
//            tv.backgroundColor = .white
//            tv.leftViewMode = .always
//            tv.layer.cornerRadius = 5
//            tv.layer.borderColor = UIColor.bluVenyard.cgColor
//            tv.layer.borderWidth = 2
//            return tv
//            
//        }()
//        
//        let calendarTextView: UITextField = {
//            let tv = UITextField()
//            tv.placeholder = "       August 21, 2017"
//            tv.textAlignment = .left
//            tv.textColor = .black
//            tv.font = UIFont(name: "Lato-Bold", size: 14)
//            tv.backgroundColor = .white
//            tv.leftViewMode = .always
//            tv.layer.cornerRadius = 5
//            tv.layer.borderColor = UIColor.bluVenyard.cgColor
//            tv.layer.borderWidth = 2
//            return tv
//            
//        }()
        
        scrollview.addSubview(mainStackView)
        view.addSubview(scrollview)
        
        //--MARK: ADD MAIN LAYOUT
        
//        refineLabelView.addSubview(refineLabel)
        vendorTypeLabelView.addSubview(vendorTypeLabel)
        vendorRatesView.addSubview(vendorRatesLabel)
        
//        refineObjectsView.addSubview(locationTextView)
//        refineObjectsView.addSubview(calendarTextView)
        vendorTypeObjectsView.addSubview(venueStackView)
        vendorRatesObjectsView.addSubview(guestsStackView)
        
        doneButtonView.addSubview(doneButton)
        doneButtonView.addSubview(filtersButton)
        
        //--MARK: ADD SUBVIEWS TO MAIN LAYOUT
        
        vendorTypeViewLeft.addSubview(venueCategoryStackLeft)
        vendorTypeViewRight.addSubview(venueCategoryStackRight)
        
        vendorRatesViewLeft.addSubview(guestsCategoryStackLeft)
        vendorRatesViewRight.addSubview(guestsCategoryStackRight)
        
        
        //--MARK: ADD LABELS TO SUBVIEWS
        
        cateringLabelView.addSubview(cateringLabel)
        cateringLabelView.bringSubview(toFront: cateringLabel)
        
        djLabelView.addSubview(djLabel)
        cateringLabelView.bringSubview(toFront: djLabel)
        
        floristLabelView.addSubview(floristLabel)
        floristLabelView.bringSubview(toFront: floristLabel)
        
        eventPlannerLabelView.addSubview(eventPlannerLabel)
        eventPlannerLabelView.bringSubview(toFront: eventPlannerLabel)
        
        bakerLabelView.addSubview(bakerLabel)
        bakerLabelView.bringSubview(toFront: bakerLabel)
        
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
        
        vendorTypeLabelView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintLabel)
        vendorTypeLabel.anchor(vendorTypeLabelView.topAnchor, left: vendorTypeLabelView.leftAnchor, bottom: vendorTypeLabelView.bottomAnchor, right: vendorTypeLabelView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        vendorTypeObjectsView.anchor(vendorTypeLabelView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintObjects)
        venueStackView.anchor(vendorTypeObjectsView.topAnchor, left: vendorTypeObjectsView.leftAnchor, bottom: vendorTypeObjectsView.bottomAnchor, right: vendorTypeObjectsView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        venueCategoryStackLeft.anchor(vendorTypeViewLeft.topAnchor, left: vendorTypeViewLeft.leftAnchor, bottom: vendorTypeViewLeft.bottomAnchor, right: vendorTypeViewLeft.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        venueCategoryStackRight.anchor(vendorTypeViewRight.topAnchor, left: vendorTypeViewRight.leftAnchor, bottom: vendorTypeViewRight.bottomAnchor, right: vendorTypeViewRight.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        vendorRatesView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintLabel)
        vendorRatesLabel.anchor(vendorRatesView.topAnchor, left: vendorRatesView.leftAnchor, bottom: vendorRatesView.bottomAnchor, right: vendorRatesView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        vendorRatesObjectsView.anchor(vendorRatesView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: rstraintObjects)
        guestsStackView.anchor(vendorRatesObjectsView.topAnchor, left: vendorRatesObjectsView.leftAnchor, bottom: vendorRatesObjectsView.bottomAnchor, right: vendorRatesObjectsView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        guestsCategoryStackLeft.anchor(vendorRatesViewLeft.topAnchor, left: vendorRatesViewLeft.leftAnchor, bottom: vendorRatesViewLeft.bottomAnchor, right: vendorRatesViewLeft.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        guestsCategoryStackRight.anchor(vendorRatesViewRight.topAnchor, left: vendorRatesViewRight.leftAnchor, bottom: vendorRatesViewRight.bottomAnchor, right: vendorRatesViewRight.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
    
        
        doneButtonView.anchor(vendorRatesObjectsView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: doneButtonConstriant)
        doneButton.anchor(doneButtonView.topAnchor, left: nil, bottom: doneButtonView.bottomAnchor, right: doneButtonView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 4, heightConstant: 0)
        filtersButton.anchor(doneButtonView.topAnchor, left: nil, bottom: doneButtonView.bottomAnchor, right: doneButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 3, heightConstant: 0)
        
        cateringLabel.anchor(cateringLabelView.topAnchor, left: venueCategoryStackLeft.leftAnchor, bottom: cateringLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        djLabel.anchor(djLabelView.topAnchor, left: venueCategoryStackLeft.leftAnchor, bottom: djLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        floristLabel.anchor(floristLabelView.topAnchor, left: venueCategoryStackLeft.leftAnchor, bottom: floristLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        eventPlannerLabel.anchor(eventPlannerLabelView.topAnchor, left: venueCategoryStackRight.leftAnchor, bottom: eventPlannerLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        bakerLabel.anchor(bakerLabelView.topAnchor, left: venueCategoryStackRight.leftAnchor, bottom: bakerLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        
        oneHundredLabel.anchor(oneHundredLabelView.topAnchor, left: guestsCategoryStackLeft.leftAnchor, bottom: oneHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        twoHundredLabel.anchor(twoHundredLabelView.topAnchor, left: guestsCategoryStackRight.leftAnchor, bottom: twoHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        threeHundredLabel.anchor(threeHundredLabelView.topAnchor, left: guestsCategoryStackLeft.leftAnchor, bottom: threeHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        fourHundredLabel.anchor(fourHundredLabelView.topAnchor, left: guestsCategoryStackRight.leftAnchor, bottom: fourHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        fiveHundredLabel.anchor(fiveHundredLabelView.topAnchor, left: guestsCategoryStackLeft.leftAnchor, bottom: fiveHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        fiveHundredPlusLabel.anchor(fivePlusHundredLabelView.topAnchor, left: guestsCategoryStackRight.leftAnchor, bottom: fivePlusHundredLabelView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width / 2 - 15, heightConstant: 0)
        
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

