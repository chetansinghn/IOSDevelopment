//
//  File.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 12/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import Foundation
import UIKit



    final class Signup: Codable {
    
    var email: String?
    var firstName : String?
    var lastName : String?
    var password : String?
    var country_code : String?
    var phone: String?
    var  role: String?
    
    enum CodingKeys: String, CodingKey {
        
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case password = "password"
        case country_code = "country_code"
        case phone = "phone"
        case role = "role"
    }
    
        init(firstName: String, lastName:String, email: String, password: String, country_code:String, phone: String,role:String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.country_code = country_code
        self.phone = phone
        self.role = role
            
        
    }
    
    required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
            lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
            password = try values.decodeIfPresent(String.self, forKey: .password)
            country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
            phone = try values.decodeIfPresent(String.self, forKey: .phone)
            role = try values.decodeIfPresent(String.self, forKey: .role)
          //  id = try values.decodeIfPresent(String.self, forKey: .id)
    }
}
