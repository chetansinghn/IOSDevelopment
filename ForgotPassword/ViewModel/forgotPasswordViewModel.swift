//
//  ForgotPasswordViewModel.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 13/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//


import UIKit

class forgotPasswordViewModel: BaseViewModel {
    
    // MARK: Variables
    
    var userService: UserServiceProtocol
    
    // MARK: Initialization
    
    // Putting dependency injection by paasing the service object in constructor and not giving the responsibility for the same to LoginViewModel
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    // MARK: Validation Methods
    
    func isValid(email: String?) -> (isValid: Bool, error: String?) {
        guard let mail = email, mail.isValidEmail() else {
            return (false, AlertMessage.INVALID_EMAIL)
        }
        return (true, nil)
    }
        
       
      
    func ForgotPassword(withEmail email: String? ) {
       
        
        let validationTuple = isValid(email: email)
        guard validationTuple.isValid, let email = email else {
            self.errorMessage = validationTuple.error
            return
        }
        self.ForgotPasswordApi(email)
    }
    
    // MARK: Api Methods
    
    func ForgotPasswordApi(_ email: String) {
     
        self.isLoading = true
        
        userService.doForgotPassword(email: email) { (result) in
         
           self.isLoading = false
            switch result {
            case .Success(_):
                self.isSuccess = true
            case .Error(let message):
                self.isSuccess = false
                self.errorMessage = message
            }
        }
    }
}

