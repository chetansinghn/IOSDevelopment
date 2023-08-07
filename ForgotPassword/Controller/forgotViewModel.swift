//
//  forgotPasswordViewController.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 13/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit

class forgotPasswordViewController: BaseViewController {
    @IBOutlet weak var emailId : UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setupClosures()
        
        
        
        
        let em = UIImage(named:"Vector")
        addrightimage(txtField: emailId, andimage: em!)
        
        
    }
    
    
    lazy var viewModel: forgotPasswordViewModel = {
        
         let obj = forgotPasswordViewModel(userService: UserService())
         self.baseVwModel = obj
         return obj
        
     }()
    
    
    
    
    func setupClosures() {
        viewModel.redirectControllerClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.navigateToHomeScreen()
            }
        }
    }
    
    func navigateToHomeScreen() {
        let coontroller = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(coontroller, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController!.pushViewController(Vc, animated: true)
                

    }
    
    func addrightimage(txtField:UITextField, andimage img:UIImage)
    {
        let rightimageview = UIImageView(frame:CGRect(x:0.0, y:0.0, width:20, height: 20))
        rightimageview.image = img
        txtField.rightView = rightimageview
        txtField.rightViewMode = .always
    }

    @IBAction func sendButton(_ sender: UIButton) {
        
        viewModel.ForgotPassword(withEmail: emailId.text)
        
    }
}
