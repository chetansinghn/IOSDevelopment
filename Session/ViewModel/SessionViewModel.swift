//
//  SessionViewModel.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 21/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import Foundation


class SessionViewModel: BaseViewModel {
    
    // MARK: Variables
    
    var userService: UserServiceProtocol
    
 private  var sessionData: [Doc] = []

   


    // MARK: Initialization
    
    // Putting dependency injection by paasing the service object in constructor and not giving the responsibility for the same to LoginViewModel
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
   
    func Session(mentorid: String, page: Int , filter: String, sessionType: String) {

        self.SessionApi(mentorid: mentorid, page: page, filter: filter, sessionType: sessionType)
    }
    
    // MARK: Api Methods
    
    func SessionApi(mentorid: String, page: Int, filter: String, sessionType: String) {
        self.isLoading = true
        userService.sessionOnline(mentorid: mentorid, page: page, filter: filter, sessionType: sessionType) { (result) in
         
           self.isLoading = false
            switch result {
            case .Success(let data):
               // print(data)
                self.isSuccess = true
                
                if let session = data as? SessionFile, let docs = session.data?.docs {
                    self.sessionData = docs
                    NotificationCenter.default.post(name: Notification.Name("DataUpdated"), object: nil)
                }
            
                let sessiondata = data as! SessionFile
                AppInstance.shared.SessionFile = sessiondata

            case .Error(let message):
                self.isSuccess = false
                self.errorMessage = message
            }
        }
    }
    
    func getSessionData() -> [Doc] {
        return sessionData
    } 
    
    func updateSessionData(_ sessions: [Doc]) {
        sessionData = sessions
    }
}

