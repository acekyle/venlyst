//
//  CustomTabBar.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/10/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeController = UINavigationController(rootViewController: RecentsViewController()) //HomeDatasourceController())
        homeController.title = "Home"
        homeController.tabBarItem.image = #imageLiteral(resourceName: "HomeButton-1")
        
        let navController = UINavigationController(rootViewController: SearchDatasourceController())
        navController.title = "Search"
        navController.tabBarItem.image = #imageLiteral(resourceName: "SearchButton-1")

        let favController = FavoritesDatasourceController() //UINavigationController(rootViewController: FavoritesDatasourceController())
        favController.title = "Favorites"
        favController.tabBarItem.image = #imageLiteral(resourceName: "likeTab")
        
        let profileController = UINavigationController(rootViewController: ProfileDatasourceController())
        profileController.title = "Profile"
        profileController.tabBarItem.image = #imageLiteral(resourceName: "AccountButton-1")
        
        let moreController = UINavigationController(rootViewController: MoreTableViewController())
        moreController.title = "More"
        moreController.tabBarItem.image = #imageLiteral(resourceName: "MenuIcon-1")
        
        
        viewControllers = [homeController, navController, favController, profileController, moreController]
        
        tabBar.isTranslucent = false
        
        let topBorder: CALayer = {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.3)
            layer.backgroundColor = UIColor(r: 229, g: 231, b: 235).cgColor
            return layer
        }()
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        tabBar.tintColor = .ventageOrange
        
    }
}
