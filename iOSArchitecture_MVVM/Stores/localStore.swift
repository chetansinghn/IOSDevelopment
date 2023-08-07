//
//  localStore.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 28/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import Foundation
 import CoreLocation
//MARK:- Shared Instance
class LocalStore: NSObject {
    
    static let shared = LocalStore()
    private override init() {
        super.init()
    }
    
    let APP_LANG_KEY = "appLang"
    
    var appLang : String {
        get {
            return UserDefaults.standard.value(forKey: APP_LANG_KEY) as? String ?? "en"
        } set {
            UserDefaults.standard.setValue(newValue, forKey: APP_LANG_KEY)
        }
    }
}
