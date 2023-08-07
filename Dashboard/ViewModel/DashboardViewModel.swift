//
//  DashboardViewModel.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 18/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit

class DashboardViewModel: BaseViewModel {
    
    
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
        
       
      
    func ForgotPassword(user_id: String? ) {
       

        let validationTuple = isValid(email: user_id)
        guard validationTuple.isValid, let user_id = user_id else {
            self.errorMessage = validationTuple.error
            return
        }
        self.updateMentorApi(user_id: user_id)
    }
    
    // MARK: Api Methods
    
    func updateMentorApi(user_id: String) {
     
        self.isLoading = true
        
        userService.getmentor(user_id: user_id) { (result) in
         
           self.isLoading = false
            switch result {
            case .Success(let data):
                self.isSuccess = true
                let programdata = data as! dashboardfile
               
            case .Error(let message):
                self.isSuccess = false
                self.errorMessage = message
            }
        }
    }
}
