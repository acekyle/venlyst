
//
//  SettingsWebController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 8/7/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents


class WebViewController: UIViewController {
    
    open var tag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

        if tag == 0 {
            linkButton.setTitle("< Settings", for: .normal)
            let url = NSURL(string: "http://www.venuelyst.com/faqs/")
            let request = URLRequest(url: url! as URL)
            webView.loadRequest(request)
        }else if tag == 1 {
            linkButton.setTitle("< Settings", for: .normal)
            let url = NSURL(string: "http://www.venuelyst.com/terms-of-use/")
            let request = URLRequest(url: url! as URL)
            webView.loadRequest(request)
        }else if tag == 2 {
            linkButton.setTitle("< Settings", for: .normal)
            let url = NSURL(string: "http://www.venuelyst.com/privacy-policy/")
            let request = URLRequest(url: url! as URL)
            webView.loadRequest(request)
        }else{
            linkButton.setTitle("< Venue", for: .normal)
        }
        
        
    }
    
    let topLabelView = UIView.createEmptyViewWithColor(backgroundColor: .bluVenyard)
    
    let webView: UIWebView = {
        let wv = UIWebView()
        return wv
    }()
    
    let linkButton: UIButton = {
        let butt = UIButton()
        butt.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        butt.backgroundColor = UIColor.ventageOrange
        butt.addTarget(self, action: #selector(backToPreviousView), for: .touchUpInside)
        return butt
    }()
    
    func setupViews(){
        
        view.addSubview(topLabelView)
        view.addSubview(webView)
        view.addSubview(linkButton)

        topLabelView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 75)
        webView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 75, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width, heightConstant: UIScreen.main.bounds.height - 75)
        linkButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width / 4, heightConstant: 35)
    }
    
    func backToPreviousView(){
        
//        if tag == 0 {
//            let tabBarController = CustomTabBarController()
//            tabBarController.selectedIndex = 4
//            present(tabBarController, animated: false, completion: nil)
//        }else{
            self.dismiss(animated: false, completion: nil)
//        }

    }
    
    
}
