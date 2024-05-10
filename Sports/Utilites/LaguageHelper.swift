//
//  LaguageHelper.swift
//  ChatApp
//
//  Created by ios Dev on 08/05/2024.
//

import Foundation

class Language {
    
    class func currentLanguage() -> String {
        return UserDefaults.standard.value(forKey: UserDefaultKeys.appLanguage) as? String ?? "en"
    }
    
    class func setAppLanguage(lang: String) {
        let defaults = UserDefaults.standard
        defaults.set(lang, forKey: UserDefaultKeys.appLanguage)
        defaults.synchronize()
    }
    
    //MARK: - func set language
    class func getLangId() -> String {
        if Language.currentLanguage() == "en" {
            return "en"
        }else{
            return "zh"
        }
    }
}
