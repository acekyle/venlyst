//
//  LoginController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/15/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents
import Alamofire

class LoginViewController: UIViewController {
    
    let coreHelper = CoreStack()
    let userHelper = CoreUserStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        
        //Dismiss Keyboard
        dismissKeyboardUsingTap(view: self.view)
        
        print("Logged in:", userHelper.isLoggedIn())
    
    }
    
    let logo: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "VenuelystIcon")
        return img
    }()
    
    let emailpic: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "EmailIcon")
        return img
    }()
    
    lazy var emailTextView: UITextField = {
        let tv = UITextField()
        tv.placeholder = "Enter valid email address"
        tv.textAlignment = .left
        tv.textColor = .black
        tv.font = UIFont(name: "Lato-Light", size: 14)
        tv.backgroundColor = .white
        tv.text = ""
        return tv
        
    }()
    
    let passwdpic: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "LockIcon")
        return img
    }()
    
    let passwdTextView: UITextField = {
        let tv = UITextField()
        tv.placeholder = "Password"
        tv.textAlignment = .left
        tv.textColor = .black
        tv.font = UIFont(name: "Lato-Light", size: 14)
        tv.backgroundColor = .white
        tv.isSecureTextEntry = true
        tv.text = ""
        return tv
    }()

    lazy var loginButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("SIGN IN", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Light", size: 14)
        butt.layer.cornerRadius = 1
        butt.backgroundColor = .ventageOrange
        butt.addTarget(self, action: #selector(self.didTryLogin), for: .touchUpInside)
        return butt
    }()
    
    let forgotPasswdButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("FORGOT PASSWORD?", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Light", size: 14)
        butt.layer.cornerRadius = 1
        butt.backgroundColor = .clear
        return butt
    }()
    
    lazy var signUpButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("SIGN UP FOR VENUELYST", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Light", size: 14)
        butt.layer.cornerRadius = 1
        butt.backgroundColor = .ventageOrange
        butt.addTarget(self, action: #selector(self.didTrySignUp), for: .touchUpInside)
        return butt
    }()
    
    
    let topBorder: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.3)
        layer.backgroundColor = UIColor.bluVenyard.cgColor
        return layer
    }()
    
    
    func setupConstriants(){
    
        logo.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: view.frame.height / 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.height / 4.5)
        
        emailTextView.anchor(logo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40, heightConstant: 40)
        emailpic.anchor(emailTextView.topAnchor, left: emailTextView.leftAnchor, bottom: emailTextView.bottomAnchor, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 40, heightConstant: 30)
       
        passwdTextView.anchor(emailTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40, heightConstant: 40)
        passwdpic.anchor(passwdTextView.topAnchor, left: passwdTextView.leftAnchor, bottom: passwdTextView.bottomAnchor, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 40, heightConstant: 30)
        
        loginButton.anchor(passwdTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40, heightConstant: 40)
        forgotPasswdButton.anchor(loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40 , heightConstant: 40)
        signUpButton.anchor(loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 155, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40 , heightConstant: 40)
    }
    
    func setupViews() {
        
        view.backgroundColor = .bluVenyard
        view.addSubview(logo)
        logo.anchorCenterXToSuperview()

        emailTextView.leftView = emailpic
        emailTextView.leftViewMode = .always
        emailTextView.addSubview(emailpic)

        passwdTextView.leftView = passwdpic
        passwdTextView.leftViewMode = .always
        passwdTextView.addSubview(passwdpic)
        
        view.addSubview(emailTextView)
        view.addSubview(passwdTextView)
        view.addSubview(loginButton)
        view.addSubview(forgotPasswdButton)
        view.addSubview(signUpButton)
        
        setupConstriants()
    }
    
    func loginUser(_ url:String, user: String, password: String, completion: ((_ response: String?) -> Void)?) {

        Alamofire.request(url ,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in switch response.result{
            case .success(let JSON):
                let data = JSON as! NSDictionary
                
                if response.response?.statusCode == 200 {
                    // -- Check if user is there
                    if let dataStatus = data["status"] as? String {
                        if dataStatus == "502" {
                            print("Grabbed 502 error: User does not exist")
                            
                            let alert = UIAlertController(title: "Not yet registered?", message: "Click sign up button below", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                        
                        if dataStatus == "501" {
                            print("Grabbed 501 error: User is inactive")
                            
                            let alert = UIAlertController(title: "Not yet active?", message: "Activate your account via confirmation email", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                        
                        return
                    }

                    self.userHelper.setEmail(self.emailTextView.text!)
                    self.userHelper.setKey(self.passwdTextView.text!)
                    self.userHelper.setApi(self.emailTextView.text!, pass: self.passwdTextView.text!)
                  
                    let email = self.userHelper.getEmail()
                    let key = self.userHelper.getKey()

                    Service.sharedInstance.fetchHomeControllerData(email: email, password: key!, completion: { (HomeDatasource) in

                        self.coreHelper.clearUserData()
                        self.coreHelper.saveUserToCoreData(userArray: HomeDatasource.users)

                    })

                    completion?("user")
                }else{
                    print("Something other than 200")
                    completion?("error")
                }
    
            case .failure(let error):
                debugPrint(error)
                completion?("error")
            }
        }
    }
    
    
    func didTryLogin(){
        
        guard let email = emailTextView.text, let password = passwdTextView.text else { return }
        
        if email.count < 1 || password.count < 1 {
            
            let alert = UIAlertController(title: "Missing Fields", message: "Please fill in all fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return

        }else{
        
            let baseURL = "http://venuelyst2.mohsinforshopify.com/api/api.php?format=json&user=\(email)&pass=\(password)"
            
            loginUser(baseURL, user: email, password: password) { (response) in
                
                if response == "error" {
                    
                    let alert = UIAlertController(title: "Error Logging In", message: "Please check your information and try again", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                    
                }
                
                if response == "user" {
                    
                    let customController = CustomTabBarController()
                    customController.selectedIndex = 1
                    self.present(customController, animated: false, completion: nil)
                }
                
            }
        }
    }
    
    
    func didTrySignUp(){
        
            let signUpController = SignupViewController()
            present(signUpController, animated: false, completion: nil)
    }
    
    
}
