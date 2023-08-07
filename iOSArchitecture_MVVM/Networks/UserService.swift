//
//  LoginAPIManager.swift
//  iOSArchitecture
//
//  Created by Amit on 23/02/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import Foundation
import UIKit

protocol UserServiceProtocol {
    
    func doLogin(email: String, password:String, role:String, completion:@escaping (Result<Any>) -> Void)
//    
//    func doSignUp(email: String, firstName: String, lastName: String, password: String, country_code: String, phone: String, role: String, completion: @escaping(Result<Any>) -> Void)
    
    func getProfile(user_id: String,   completion: @escaping(Result<Any>) -> Void)
    
    func updateProfile(firstName:String, _id:String,  lastName:String, status:String, phone:String, image:Data, country_code:String,gender:String,bio:String, city:String, postalcode:String, address:String,language:String,date_of_birth:String, province: String, completion: @escaping(Result<Any>) ->Void)
    func doForgotPassword(email: String, completion:@escaping (Result<Any>) -> Void)
    
    func getmentor(user_id: String, completion:@escaping (Result<Any>) -> Void)
    
    
    func sessionOnline(mentorid: String, page: Int, filter: String, sessionType: String, completion:@escaping (Result<Any>) -> Void)
    
}





public class UserService: APIService, UserServiceProtocol {
    func updateProfile(firstName: String, _id: String, lastName: String, status: String, phone: String, image: Data, country_code: String, gender: String, bio: String, city: String, postalcode: String, address: String, language: String, date_of_birth: String, province: String, completion: @escaping (Result<Any>) -> Void) {
        
        let param = [updateProfileKeys.firstName:firstName, updateProfileKeys._id: _id, updateProfileKeys.lastName:lastName, updateProfileKeys.status:"1", updateProfileKeys.phone:phone, updateProfileKeys.country_code:country_code, updateProfileKeys.gender:gender, updateProfileKeys.bio:bio, updateProfileKeys.city:city, updateProfileKeys.postalcode:postalcode, updateProfileKeys.language:language, updateProfileKeys.address:address, updateProfileKeys.date_of_birth:date_of_birth, updateProfileKeys.province:province]
        let files = [File(name: "image", filename: "image.jpg", data: image)]
        let url = Config.BASE_URL + Config.profileUpdate
        super.startService(with: .PUT, path:Config.profileUpdate, parameters: param, files: [], modelType: UpdateModel.self) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let data):
                    // Parse Here
                    completion(.Success(data!))
                case .Error(let message):
                    completion(.Error(message))
                    
                }
            }
        }
    }
    
   
    
    func getProfile(user_id: String, completion: @escaping (Result<Any>) -> Void) {
        let param = [getProfileKeys.user_id: user_id] as [String : Any]
        let url = Config.BASE_URL + Config.getprofile
        super.startService(with: .GET, path:Config.getprofile, parameters: param, files: [], modelType: UserProfile.self) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let data):
                    // Parse Here
                    completion(.Success(data!))
                case .Error(let message):
                    completion(.Error(message))
                    
                }
            }
        }
    }
   
    
    func sessionOnline(mentorid: String, page: Int, filter: String, sessionType: String, completion: @escaping (Result<Any>) -> Void) {
        let param = [SessionKeys.mentorid: mentorid, SessionKeys.page: page, SessionKeys.filter: filter, SessionKeys.sessionType: sessionType] as [String : Any]
        let url = Config.BASE_URL + Config.sessionOnline
         //   print(url)
            super.startService(with: .GET, path:Config.sessionOnline, parameters: param, files: [], modelType: SessionFile.self) { (result) in
            DispatchQueue.main.async {
                    switch result {
                    case .Success(let data):
                        // Parse Here
                        completion(.Success(data!))
                    case .Error(let message):
                        completion(.Error(message))
        
                        
                    }
                }
            }
    }
    
    
//    func fetchDataWithToken() {
//        // Get the saved token from the TokenManager
//        if let token = TokenManager.shared.gettoken() {
//            // Now you can use the token for making API requests or any other purpose
//            print("Token: \(token)")
//            // Example: Make an API request using the token
//            // YourNetworkingClass.makeRequestWithToken(token: token)
//        } else {
//            // Handle the case when the token is not available (e.g., user is not logged in)
//            print("Token not available.")
//        }
//    }
//}


    
    func getmentor(user_id: String, completion: @escaping (Result<Any>) -> Void) {
         
            let param = [keys1.user_id:user_id]
           let url = Config.BASE_URL + Config.getmentor
          //  print(url)
            super.startService(with: .GET, path:Config.getmentor, parameters: param, files: [], modelType: dashboardfile.self) { (result) in
            DispatchQueue.main.async {
                    switch result {
                    case .Success(let data):
                        // Parse Here
                        completion(.Success(data!))
                    case .Error(let message):
                        completion(.Error(message))
        
                        
                    }
                }
            }
        }
        
    
    
    

//    func doprofileupdate( firstName: String, _id: String, lastName: String, status: String, country_code: String, phone: String, gender: String, bio: String, city: String, postalcode: String, language: String, skillsdata: String, address: String, date_of_birth: String, province: String, validationid: String, completion: @escaping (Result<Any>) -> Void) {
//
       
    
    func doForgotPassword(email: String, completion: @escaping (Result<Any>) -> Void) {
        let param = [Keys1.email:email]
      //  let url = Config.BASE_URL + Config.forgotPassword
        //print(url)
        super.startService(with: .GET, path:Config.forgotPassword, parameters: param, files: [], modelType: forgotpassword.self) { (result) in
        DispatchQueue.main.async {
                switch result {
                case .Success(let data):
                    // Parse Here
                    completion(.Success(data!))
                case .Error(let message):
                    completion(.Error(message))
    
                    
                }
            }
        }
    }
    
    
    
//    func doSignUp(email: String, firstName: String, lastName: String, password: String, country_code: String, phone: String, role: String, completion: @escaping (Result<Any>) -> Void) {
//
//        let param = [Key.email:email, Key.firstName:firstName, Key.lastName:lastName, Key.password : password, Key.country_code: country_code, Key.phone: phone, Key.role : role]
//
//        super.startService(with: .POST, path:Config.login, parameters: param, files: [], modelType: User.self) { (result) in
//        DispatchQueue.main.async {
//                switch result {
//                case .Success(let data):
//                    // Parse Here
//                    completion(.Success(data!))
//                case .Error(let message):
//                    completion(.Error(message))
//
//                }
//            }
//        }
//    }
    
    
    func doLogin(email: String, password:String, role:String, completion:@escaping (Result<Any>) -> Void) {
        
        
        let param = [Keys.email:email, Keys.password : password, Keys.role : role]
       
        super.startService(with: .POST, path:Config.login, parameters: param, files: [], modelType: LoginModel.self) { (result) in
        DispatchQueue.main.async {
                switch result {
                case .Success(let data):
                    // Parse Here
                    completion(.Success(data!))
                case .Error(let message):
                    completion(.Error(message))
                    
                }
            }
        }
    }
    


    }
