//
//  DefaultManager.swift
//  Prego
//
//  Created by owner on 9/4/19.
//  Copyright © 2019 Y2M. All rights reserved.
//

import Foundation

class DefaultManager {
    
    //User object defualts
    static func saveUserDefault(user: User) {
        
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: Config.userDefault)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func getUserDefault() -> User? {
        
        var user: User?
        if let userData = UserDefaults.standard.data(forKey: Config.userDefault),
            let userDefault = try? JSONDecoder().decode(User.self, from: userData) {
            
            user = userDefault
        }
        return user
    }
    
    
    //Language defaults
    static func saveLanguageDefault(language: String) {
        let userdef = UserDefaults.standard
        userdef.set(language , forKey: Config.languageDefault)
        userdef.synchronize()
    }
    

    static func saveTitleBranchDefault(value: String) {
        let userdef = UserDefaults.standard
        userdef.set(value , forKey: Config.titleBranchDefault)
        userdef.synchronize()
    }
    
    static func saveAddressBranchDefault(value: String) {
        let userdef = UserDefaults.standard
        userdef.set(value , forKey: Config.addressBranchDefault)
        userdef.synchronize()
    }
    
    static func getLanguage() -> String? {
        var language: String? = nil
        if let lang = UserDefaults.standard.string(forKey: Config.languageDefault) {
            language = lang
        }
        return language
    }
    
    static func getLanguageDefault() -> String? {
        let lang: String?
        if let language = getLanguage(){
            if language.isEmpty{
                lang = Config.English
            }else{
                lang = language
            }
        }else{
            let deviceLang = Locale.current.languageCode
            if (deviceLang?.isEmpty)! || deviceLang == nil {
                lang = Config.English
            }else{
                lang = deviceLang
            }
        }
        return lang!
    }
    
    
    
    
    //token defaults
    static func saveTokenDefault(token: String) {
        UserDefaults.standard.set(token , forKey: Config.tokenDefault)
    }
    
    public static func getUserToken() -> String? {
        
        var token: String? = nil
        if let tok = UserDefaults.standard.string(forKey: Config.tokenDefault) {
            token = tok
        }
        return token
    }
}


