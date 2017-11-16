//
//  CustomSearchController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/7/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit

class CustomSearchController: UISearchController {
    
    var customSearchBar: CustomSearchBar!
    var searchController = SearchDatasourceController()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Dismiss Keyboard
        let tap = UITapGestureRecognizer(target: getTopViewController()?.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        
    }

    
    
    func configureSearchBar(frame: CGRect, font: UIFont, textColor: UIColor, bgColor: UIColor) {
        customSearchBar = CustomSearchBar(frame: frame, font: font , textColor: textColor)
        
        customSearchBar.barTintColor = bgColor
        customSearchBar.tintColor = textColor
        customSearchBar.showsBookmarkButton = false
        customSearchBar.showsCancelButton = false
        customSearchBar.backgroundColor = UIColor.bluVenyard
        
        let textField = customSearchBar.value(forKey: "searchField") as! UITextField
        
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        
//        customSearchBar.searchTextPositionAdjustment.horizontal = -15.0
//        customSearchBar.setPositionAdjustment(UIOffsetMake(-326.0, 0.0), for: .search)
        
    }

    init(searchResultsController: UIViewController!, searchBarFrame: CGRect, searchBarFont: UIFont, searchBarTextColor: UIColor, searchBarTintColor: UIColor) {
        super.init(searchResultsController: searchResultsController)
        
        configureSearchBar(frame: searchBarFrame, font: searchBarFont, textColor: searchBarTextColor, bgColor: searchBarTintColor)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
