//
//  LoginViewModel.swift
//  iOSArchitecture_MVVM
//
//  Created by Surjeet Singh on 14/03/2019.
//  Copyright © 2019 Surjeet Singh. All rights reserved.
//

import UIKit
//import CloudKit
//import IQKeyboardManagerSwift

class LoginViewModel: BaseViewModel {
    
    // MARK: Variables
    
    var userService: UserServiceProtocol
    
    // MARK: Initialization
    
    // Putting dependency injection by paasing the service object in constructor and not giving the responsibility for the same to LoginViewModel
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    // MARK: Validation Methods
    
    func isValid(email: String?, password: String?) -> (isValid: Bool, error: String?) {
        guard let mail = email, mail.isValidEmail() else {
            return (false, AlertMessage.INVALID_EMAIL)
        }
        
        guard let pswd = password, pswd.count >= 6 else {
            return (false, AlertMessage.INVALID_PASSWORD)
        }
        return (true, nil)
    }
      
    func login(withEmail email: String?, password: String? ,role:String?) {
        let role = "1"
        
        let validationTuple = isValid(email: email, password: password)
        guard validationTuple.isValid, let email = email, let password = password else {
            self.errorMessage = validationTuple.error
            return
        }
        self.loginApi(email, password: password, role: role)
    }
    
    // MARK: Api Methods
    
    func loginApi(_ email: String, password: String, role: String) {

        self.isLoading = true
        let role = "1"
        userService.doLogin(email: email, password: password ,role:role) { (result) in
         
           self.isLoading = false
            switch result {
            case .Success(let data):
                self.isSuccess = true
                let login = data as! LoginModel
                let token = login.data?.token
                let useriD = login.data?._id
                AppInstance.shared.authToken = token
                AppInstance.shared.user_Id = useriD

                if let storedToken = AppInstance.shared.authToken , let userid = AppInstance.shared.user_Id {
                print("Retreived token for user \(login.data?.email)': \(storedToken) and user id id \(userid)")
                    
                }
                else {
                    print("User token not found")
                }
                
            
                
                UserDefaults.standard.setValue(true, forKey: "autoLoginEnabled")
            case .Error(let message):
                self.isSuccess = false
                self.errorMessage = message
            }
        }
    }
}
