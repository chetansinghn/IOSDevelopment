//
//  signupViewModel.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 12/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import Foundation
class signupViewModel: BaseViewModel {
    
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
      
    func signup(withEmail email: String?,firstName: String?, lastName: String?, password: String?, country_code: String?, phone : String?, role:String?) {
        let role = "1"
        let country_code = "+91"
       let phone =  "7876786786"
        
        
        let validationTuple = isValid(email: email, password: password)
        guard validationTuple.isValid, let email = email, let password = password else {
            self.errorMessage = validationTuple.error
            return
        }
//      self.signupApi(email, password: password, role: role, firstName: firstName, lastName: //lastName, country_code: country_code, phone: phone )
    }
    
    // MARK: Api Methods
    
    func signupApi(_ email: String, password: String, role: String,firstName: String, lastName: String, country_code: String, phone: String) {
        let role = "1"
//        let country_code = "+91"
//       let phone =  "7876786786"
        self.isLoading = true
        
////        userService.doSignUp(email: email, password: password ,role:role, lastName: lastName, firstName: firstName, phone: phone, country_code: country_code) { (result) in
//
//           self.isLoading = false
//            switch result {
//            case .Success(_):
//                self.isSuccess = true
//            case .Error(let message):
//                self.isSuccess = false
//                self.errorMessage = message
//            }
//        }
    }
}
