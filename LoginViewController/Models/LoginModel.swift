//
//  LoginModel.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 25/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//


import Foundation
import UIKit

final class LoginModel: Codable {
    var status: String?
    var messageId: Int?
    var message: String?
    var data: LoginData?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case messageId = "messageId" 
        case message = "message"
        case data = "data"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        messageId = try values.decodeIfPresent(Int.self, forKey: .messageId) 
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
    }
}

struct LoginData : Codable{
    
    let _id : String?
    let name : String?
    let email : String?
    let role : Int?
    let password : String?
    let image : String?
    let myreferalcode : String?
    let token : String?
    
    
    enum CodingKeys: String, CodingKey{
        
        case _id = "_id"
        case name = "name"
        case email = "email"
        case role = "role"
        case password = "password"
        case image = "image"
        case myreferalcode = "myreferalcode"
        case token = "token"
        
    }
    
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        image = try values.decodeIfPresent(String.self, forKey:  .image)
        myreferalcode = try values.decodeIfPresent(String.self, forKey: .myreferalcode)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}
