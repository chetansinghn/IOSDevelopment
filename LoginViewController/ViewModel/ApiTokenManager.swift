//
//  ApiTokenManager.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 25/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import Foundation


class TokenManager {
    
    static let shared = TokenManager()
    
    private let userDefaults = UserDefaults.standard
    
    private let tokenKey = "apitoken"
    
    private init() {}
    
    
    func saveToken(token: String) {
        userDefaults.set(token, forKey: tokenKey)
    }
    
    
    func gettoken() -> String? {
        return userDefaults.string(forKey: tokenKey)
    }
    
    func clearToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }

}
