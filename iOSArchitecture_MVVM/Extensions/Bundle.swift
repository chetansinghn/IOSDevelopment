//
//  Bundle.swift
//  Patient
//
//  Created by Amit Kumar Shukla on 5/24/18.
//  Copyright © 2018 Amit Kumar Shukla. All rights reserved.
//

import Foundation

extension Bundle {
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
   

    private static var bundle: Bundle!

    public static func localizedBundle() -> Bundle! {
            let appLang = UserDefaults.standard.value(forKey: LocalStore.shared.APP_LANG_KEY) as? String ?? "en"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        return bundle;
    }

    
    
    
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
