//
//  UserProfile.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 15/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct UserProfile: Codable {
    let status: String
    let messageID: Int
    let message: String
    let data: ProfileData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case messageID = "messageID"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)!
        messageID = try values.decodeIfPresent(Int.self, forKey: .messageID)!
        message = try values.decodeIfPresent(String.self, forKey: .message)!
        data = try values.decodeIfPresent(ProfileData.self, forKey: .data)
    }
}

// MARK: - DataClass
struct ProfileData: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let countryCode: String
    let phone: String
    let email: String
    let city: String
    let address: String
    let province: String
    let postalcode: String
    let bio: String
    let image: String?
    let skills: [Skill]
    let socketID: String
  //  let country: String
    let dateOfBirth: String
    let gender: String
    let language: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName = "firstName"
        case lastName = "lastName"
        case countryCode = "country_code"
        case phone = "phone"
        case email = "email"
        case city = "city"
        case address = "address"
        case province = "province"
        case postalcode = "postalcode"
        case bio = "bio"
        case image = "image"
        case socketID = "socketId"
        //case country = "country"
        case dateOfBirth = "date_of_birth"
        case gender = "gender"
        case language = "language"
        case skills = "skills"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)!
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)!
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)!
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)!
        phone = try values.decodeIfPresent(String.self, forKey: .phone)!
        email = try values.decodeIfPresent(String.self, forKey: .email)!
        city = try values.decodeIfPresent(String.self, forKey: .city)!
        address = try values.decodeIfPresent(String.self, forKey: .address)!
        province = try values.decodeIfPresent(String.self, forKey: .province)!
        postalcode = try values.decodeIfPresent(String.self, forKey: .postalcode)!
        bio = try values.decodeIfPresent(String.self, forKey: .bio)!
        image = try values.decodeIfPresent(String.self, forKey: .image)!
        socketID = try values.decodeIfPresent(String.self, forKey: .socketID)!
    //    country = try values.decodeIfPresent(String.self, forKey: .country)!
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)!
        gender = try values.decodeIfPresent(String.self, forKey: .gender)!
        language = try values.decodeIfPresent(String.self, forKey: .language)!
        skills = try values.decodeIfPresent([Skill].self, forKey: .skills)!
    }
}

// MARK: - Skill
struct Skill: Codable {
    let skillName: String
    let categoryID: String
    let certificates: String
    
    enum CodingKeys: String, CodingKey {
        case skillName = "skillName"
        case categoryID = "category_id"
        case certificates = "certificates"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        skillName = try values.decodeIfPresent(String.self, forKey: .skillName)!
        categoryID = try values.decodeIfPresent(String.self, forKey: .categoryID)!
        certificates = try values.decodeIfPresent(String.self, forKey: .certificates)!
    }
}



















