//
//  SignupViewController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/15/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.


import LBTAComponents
import Alamofire

class SignupViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        //Dismiss Keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

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
    
    let namepic: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "NameIcon")
        return img
    }()
    
    lazy var nameTextView: UITextField = {
        let tv = UITextField()
        tv.placeholder = "Enter first name"
        tv.textAlignment = .left
        tv.textColor = .black
        tv.font = UIFont(name: "Lato-Light", size: 14)
        tv.backgroundColor = .white
        tv.text = ""
        return tv
    }()
    
    let numberpic: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "PhoneIcon")
        return img
    }()
    
    let numberTextView: UITextField = {
        let tv = UITextField()
        tv.placeholder = "Enter a valid phone number"
        tv.textAlignment = .left
        tv.textColor = .black
        tv.font = UIFont(name: "Lato-Light", size: 14)
        tv.backgroundColor = .white
        tv.text = ""
        return tv
    }()
    
    let confirmpasswdpic: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "LockIcon")
        return img
    }()
    
    let confirmPasswdTextView: UITextField = {
        let tv = UITextField()
        tv.placeholder = "Confirm password"
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
    
    lazy var backToLoginButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("BACK TO LOGIN", for: .normal)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = UIFont(name: "Lato-Light", size: 14)
        butt.layer.cornerRadius = 1
        butt.backgroundColor = .clear
        butt.addTarget(self, action: #selector(self.backToLogin), for: .touchUpInside)
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
        
        nameTextView.anchor(logo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40, heightConstant: 40)
        namepic.anchor(nameTextView.topAnchor, left: nameTextView.leftAnchor, bottom: nameTextView.bottomAnchor, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 40, heightConstant: 30)
        
        emailTextView.anchor(nameTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40, heightConstant: 40)
        emailpic.anchor(emailTextView.topAnchor, left: emailTextView.leftAnchor, bottom: emailTextView.bottomAnchor, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 40, heightConstant: 30)
        
        numberTextView.anchor(emailTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40, heightConstant: 40)
        numberpic.anchor(numberTextView.topAnchor, left: numberTextView.leftAnchor, bottom: numberTextView.bottomAnchor, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 40, heightConstant: 30)
       
        passwdTextView.anchor(numberTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40, heightConstant: 40)
        passwdpic.anchor(passwdTextView.topAnchor, left: passwdTextView.leftAnchor, bottom: passwdTextView.bottomAnchor, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 40, heightConstant: 30)
        
        confirmPasswdTextView.anchor(passwdTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40, heightConstant: 40)
        confirmpasswdpic.anchor(confirmPasswdTextView.topAnchor, left: confirmPasswdTextView.leftAnchor, bottom: confirmPasswdTextView.bottomAnchor, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 40, heightConstant: 30)
        
        loginButton.anchor(confirmPasswdTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40, heightConstant: 40)
        
        backToLoginButton.anchor(loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width - 40 , heightConstant: 40)

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
        
        confirmPasswdTextView.leftView = confirmpasswdpic
        confirmPasswdTextView.leftViewMode = .always
        confirmPasswdTextView.addSubview(confirmpasswdpic)
        
        nameTextView.leftView = namepic
        nameTextView.leftViewMode = .always
        nameTextView.addSubview(namepic)
        
        numberTextView.leftView = numberpic
        numberTextView.leftViewMode = .always
        numberTextView.addSubview(numberpic)
        
        view.addSubview(nameTextView)
        view.addSubview(emailTextView)
        view.addSubview(numberTextView)
        view.addSubview(passwdTextView)
        view.addSubview(confirmPasswdTextView)

        view.addSubview(loginButton)
        view.addSubview(backToLoginButton)
        
        setupConstriants()
    }
    
    func registerUser(_ url: String, user: String, password: String, completion: ((_ response: String?) -> Void)?) {
        let params = [
            "user": user,
            "pass": password,
            ]

        Alamofire.request(url ,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in switch response.result{
            case .success(let JSON):
                let data = JSON as! NSDictionary
                
                print("Response: \(response.result)")
                
                print("Data:", data)
                
                if let dataStatus = data["status"] as? String {
                    if dataStatus == "1" {

                        let alert = UIAlertController(title: "Confirmation email", message: "Please finish registration by confirming your email ", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }else{
                        
                        let alert = UIAlertController(title: "Already in use", message: "Email already in use, Please login", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
                completion?("user")
                
            case .failure(let error):
                debugPrint(error)
                completion?("error")
                }
        }
    }
    
    func didTryLogin(){
        
        guard let email = emailTextView.text, let password = passwdTextView.text, let name = nameTextView.text, let phoneNumber  = numberTextView.text else { return }

        let baseUrl = "http://venuelyst2.mohsinforshopify.com/api/registration_api.php?email=\(email)&pass=\(password)&format=json"
        
        registerUser(baseUrl, user: email, password: password) { (response) in
            
            print("Response to registration is \(String(describing: response))")
            
            if response == "error" {
                let alert = UIAlertController(title: "Error Logging in", message: "Please check your information and try again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if response == "user"{
                
                
                
            }
            
        }
        
        print("After registration....")


    }
    
    
    func backToLogin(){
        let loginController = LoginViewController()
        present(loginController, animated: false, completion: nil)

    }

}
