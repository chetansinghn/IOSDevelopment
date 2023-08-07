//
//  AppInstance.swift
//  Docsink
//
//  Created by Amit Kumar Shukla on 9/6/16.
//  Copyright (c) 2016 Docsink. All rights reserved.
//
// Use this class for storing shared instances

import Foundation

class AppInstance: NSObject {
   
    static let shared = AppInstance()
    var LoginModel: LoginModel?
    var SessionFile: SessionFile?
    var authToken: String?
    var user_Id: String?
//    var getProfile: UserProfile?
//    var updateData: UpdateModel?
    override init() {
        super.init()
    }
}
