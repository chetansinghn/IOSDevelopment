//
//  user.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 13/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import Foundation
import UIKit

final class forgotpassword: Codable {
   
    var email : String?
    
    
    
    enum CodingKeys: String, CodingKey {
     
        case email = "email"
   
    }
    
    init( email: String) {
       
        self.email = email
        
    }
    
    required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
           
            email = try values.decodeIfPresent(String.self, forKey: .email)
           
          
    }
}
