//
//  MoreTableViewController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/11/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit


struct settingsLabels {
    
    var label: String!
    
    init(label: String) {
        self.label = label
    }
}

class MoreTableViewController: UITableViewController {
    
    let settings = ["FAQ","Terms","Policy","Rate VenueLyst","Share With Friends"]
    var cellId = "moreId"
    var settingsArray = [settingsLabels]()
    
    let signoutButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("SIGN OUT", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Regular", size: 12)
        butt.layer.cornerRadius = 1
        butt.backgroundColor = .ventageOrange
        butt.addTarget(self, action: #selector(signout), for: .touchUpInside)
        return butt
    }()
    
    
    func signout() {
        self.present(LoginViewController(), animated: true) {
            userHelper.clearData()
        }
    }
    
//    func setupSignoutButton(){
//        view.addSubview(signoutButton)
//        signoutButton.anchor(nil, left: nil, bottom: tableView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 45)
//        view.addConstraint(NSLayoutConstraint(item: signoutButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavView()
        setupTableView()

        
        
        settingsArray = [settingsLabels(label: "\(settings[0])"),
                         settingsLabels(label: "\(settings[1])"),
                         settingsLabels(label: "\(settings[2])"),
                         settingsLabels(label: "\(settings[3])"),
                         settingsLabels(label: "\(settings[4])")]

        
    }
    
    override func viewDidAppear(_ animated: Bool) { UIApplication.shared.statusBarStyle = .lightContent }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0 //self.tableView.bounds.size.height - CGFloat(settingsArray.count * 70)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = Bundle.main.loadNibNamed("MoreTableViewCell", owner: self, options: nil)?.first as! MoreTableViewCell
        
        cell.settingsLabel.text = settingsArray[indexPath.item].label
                
        cell.accessoryType = .disclosureIndicator
        cell.isHighlighted = false
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15)
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.item < 3 {
            let settingsController = WebViewController()
            settingsController.tag = indexPath.item
            self.present(settingsController, animated: false, completion: {})
        }else if indexPath.item == 3 {
            let appDel = AppDelegate()
            appDel.requestReview()
        }else {
            shareTapped()
        }
        
        
    }
    
    func shareTapped() {
        
        let text = "Check out the Venuelyst!"
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    func setupNavView() {
        
        let nav = self.navigationController?.navigationBar
        let rightButton =  UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signout))
        
        nav?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nav?.shadowImage = UIImage()
        nav?.barTintColor = .bluVenyard
        nav?.isTranslucent = false
        nav?.topItem?.title = "Venuelyst"
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = UIColor.ventageOrange
        
    }
    
    func setupTableView() {
        
        tableView.isScrollEnabled = false
        tableView.separatorColor = UIColor(r: 230, g: 230, b: 230)
        tableView.tableFooterView = UIView(frame: .zero)
        
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
