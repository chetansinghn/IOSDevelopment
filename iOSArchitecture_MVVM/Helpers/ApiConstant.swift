//
//  ApiConstant.swift
//  iOSArchitecture_MVVM
//
//  Created by Surjeet Singh on 15/03/2019.
//  Copyright © 2019 Surjeet Singh. All rights reserved.
//

import UIKit

enum Config {
    
    // Copy base url here
    
    #if DEVELOPMENT
    static let BASE_URL:String = "http://54.190.192.105:9192/"
    #else
    static let BASE_URL:String = "http://54.190.192.105:9192/"
    #endif
    
    // All end points will be here
  //  static let login = "registration_ctrl/login"
   static let login = "auth/login"
   static let signup = "mentor/register"
    static let forgotPassword = "auth/forgot-password"
    static let profileUpdate = "mentor/update"
    static let getmentor = "mentee/programAndMentorDetailTotalcount"
    static let sessionOnline = "mentorship/getAllDaywise"
    static let getprofile = "mentor/getUser"
    
}
enum SessionKeys {
    
    static let mentorid = "mentorid"
    static let  page = "page"
    static let filter = "filter"
    static let  sessionType  = "sessionType"
}

enum Keys {
    static let email    = "email"
    static let password = "password"
    static let  role    = "role"
}


enum Key {
    static let email = "email"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let password = "password"
    static let phone = "phone"
    static let role = "role"
    static let country_code = "country_code"
    
}

enum Keys1{
    static let email = "email"
    
}
enum keys1{
    static let user_id = "user_id"
    
}


enum getProfileKeys {
    static let user_id = "user_id"
}

enum updateProfileKeys{
    static let firstName = "firstName"
    static let _id = "_id"
    static let lastName = "lastName"
    static let status = "status"
    static let phone = "phone"
    static let image = "image"
    static let country_code = "country_code"
    static let gender = "gender"
    static let bio = "bio"
    static let city = "city"
    static let postalcode = "postalcode"
    static let address = "address"
    static let language = "language"
    static let date_of_birth = "date_of_birth"
    static let province = "province"
    
}

//enum Keys2{
//
//   // static let _id = "_id"
//    static let firstName = "firstName"
//    static let lastName = "lastName"
//    static let country_code = "country_code"
//    static let phone = "phone"
//    static let email = "email"
//    static let city = "city"
//    static let address = "address"
//    static let province = "province"
//    static let postalcode = "postalcode"
//    static let bio = "bio"
//    static let status = "status"
//    static let validationid = "validationid"
//    static let gender = "gender"
//    static let role = "role"
////    static let image = "image"
////    static let category_id = "category_id"
//    static let language = "langauge"
//    static let date_of_birth = "date_of_birth"
//    static let skillName = "skillName"
//}
