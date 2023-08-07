//
//  SignInTableViewController.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 05/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit
import SideMenu
class SignUpTableViewController: UITableViewController {
    
    var validation = Validation()
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var referralCode: UITextField!
    
    @IBOutlet weak var emailId: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var numberEnter: UITextField!
    
    @IBOutlet weak var mobileNumber: UITextField!
    
    @IBOutlet weak var signupImage: UIImageView!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var sideMenubutton: UIButton!
    
    var baseVwModel: BaseViewModel? {
        didSet {
            initBaseModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let em = UIImage(named:"Vector")
        addrightimage(txtField: emailId, andimage: em!)
       
        let pass = UIImage(named:"image 1 (Traced)")
        addrightimage(txtField: password, andimage: pass!)
        
        let referral = UIImage(named:"layer1")
        addrightimage(txtField: referralCode, andimage: referral!)
        
        let first = UIImage(named:"Group-2")
        addrightimage(txtField: firstName, andimage: first!)
        
        let last = UIImage(named:"Group-2")
        addrightimage(txtField: lastName, andimage: last!)
        
        
        let mobileNo = UIImage(named:"Group 102")
        addrightimage(txtField: mobileNumber, andimage: mobileNo!)
        
        
        
      
        

        super.viewDidLoad()
    
        signupImage.image = UIImage(imageLiteralResourceName:"Group 103")

    }
    

    lazy var viewModel: signupViewModel = {
         let obj = signupViewModel(userService: UserService())
         self.baseVwModel = obj
         return obj
     }()
    
    
    func addrightimage(txtField:UITextField, andimage img:UIImage)
    {
        let rightimageview = UIImageView(frame:CGRect(x:0.0, y:0.0, width:20, height: 20))
        rightimageview.image = img
        txtField.rightView = rightimageview
        txtField.rightViewMode = .always
    }
    
    
    
    
    
    final func initBaseModel() {
        // Native binding
        baseVwModel?.showAlertClosure = { [weak self] (_ type:AlertType) in
            DispatchQueue.main.async {
                if type == .success, let message = self?.baseVwModel?.alertMessage  {
//                    Helper.showNotificationAlert(nil, message, type)
                    UIAlertController.showAlert(title: "", message: message)
                } else {
                    let message = self?.baseVwModel?.errorMessage ?? "Some Error occured"
//                    Helper.showNotificationAlert(nil, message , type)
                    UIAlertController.showAlert(title: "", message: message)
                }
            }
        }
            
        baseVwModel?.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.baseVwModel?.isLoading ?? false
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            }
        }
    }
    
    
    

    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        
       if segmentControl.selectedSegmentIndex == 0
        {
           signupImage.image = UIImage(imageLiteralResourceName:"Group 103")
           referralCode.text = ""
           emailId.text = ""
           firstName.text = ""
           lastName.text = ""
           numberEnter.text = ""
           mobileNumber.text = ""
        
        }
        else
        {
            signupImage.image =  UIImage(imageLiteralResourceName: "Group")
            referralCode.text = ""
            emailId.text = ""
            firstName.text = ""
            lastName.text = ""
            numberEnter.text = ""
            mobileNumber.text = ""
        }
        
    }
    
    @IBAction func continueBtnPressed(_ sender: UIButton) {
        let email = emailId.text;
        
        let isValidateEmail = self.validation.validateEmailId(emailID: email!)
        if (isValidateEmail == false){
           print("Incorrect or empty fields")
           return
        }
        if ( isValidateEmail == true)
             {
                 print("Email is correct")

        }
         
        else {
               print("invalid or empty fields")
        }
     
    }
    
    @IBAction func sideMenuButton(_ sender: UIButton) {
        

    }
    
        
    @IBAction func loginButtonPressed(_ sender: UIButton) {let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as?  LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
   
    
    }
    

