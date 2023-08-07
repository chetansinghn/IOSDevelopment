//
//  ProfileViewModel.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 15/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//


import Foundation


class ProfileViewModel: BaseViewModel {
    
    // MARK: Variables
    
    private(set) var userService: UserServiceProtocol
    var updateData: UpdateModel?
    var getProfile: UserProfile?

    // MARK: Initialization
    
    // Putting dependency injection by passing the service object in the constructor
    init(userService: UserServiceProtocol) {
        self.userService = userService
        super.init()
    }
    
    // MARK: API Methods
    
    func updateProfileApi(firstName: String, _id: String, lastName: String, status: String, phone: String, image: Data, country_code: String, gender: String, bio: String, city: String, postalcode: String, address: String, language: String, date_of_birth: String, province: String) {
        self.isLoading = true
        userService.updateProfile(firstName: firstName, _id: _id, lastName: lastName, status: status, phone: phone, image: image, country_code: country_code, gender: gender, bio: bio, city: city, postalcode: postalcode, address: address, language: language, date_of_birth: date_of_birth, province: province) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .Success(let data):
             
                if let updateData = data as? UpdateModel {
//                   self.updateData = updateData
//                    self.isSuccess = true
                    
                } else {
                    self.isSuccess = false
                    self.errorMessage = "Unexpected data format received."
                }
            case .Error(let message):
                self.isSuccess = false
                self.errorMessage = message
            }
        }
    }
   
    func getprofile(user_id: String) {
        self.getApi(user_id: user_id)
    }
    
    // MARK: Private Helper Methods
    
    private func getApi(user_id: String) {
        self.isLoading = true
        userService.getProfile(user_id: user_id) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .Success(let data):
                if let profileData = data as? UserProfile {
                    self.getProfile = profileData
                    self.isSuccess = true
                } else {
                    self.isSuccess = false
                    self.errorMessage = "Unexpected data format received."
                }
            case .Error(let message):
                self.isSuccess = false
                self.errorMessage = message
            }
        }
    }
}





