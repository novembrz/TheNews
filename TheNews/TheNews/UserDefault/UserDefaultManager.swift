//
//  UserDefaultManager.swift
//  TheNews
//
//  Created by Дарья on 12.11.2020.
//

import Foundation

struct UserDefaultManager {
    
    static let (sourceTitleKey, sourceURLKey) = ("sourceTitle", "sourceURL")
    static let userSessionKey = "FeedNews"
    private static let userDefault = UserDefaults.standard
    
    struct UserDetails {
        let savedSourcesTitle: [String]
        let savedSourcesURL: [String]
        
        init(_ json: [String: [String]]) {
            
            self.savedSourcesTitle = json[sourceTitleKey] ?? ["Banki.ru", "Finam.ru"]
            
            self.savedSourcesURL = json[sourceURLKey] ?? [CurrentURL.getBankiURlString(), CurrentURL.getFinamURlString()]
        }
    }
    static func saveSources(sourcesTitle: [String], sourcesURL: [String]) {
        userDefault.set([sourceTitleKey: sourcesTitle, sourceURLKey: sourcesURL], forKey: userSessionKey)
    }
    
    static func getSourcesTitle() -> [String] {
        
        let value = UserDetails((userDefault.value(forKey: userSessionKey) as? [String: [String]]) ?? [:])
        return value.savedSourcesTitle
    }

    static func getSourcesURL() -> [String] {
        let value = UserDetails((userDefault.value(forKey: userSessionKey) as? [String: [String]]) ?? [:])
        return value.savedSourcesURL
    }

    static func clearUserData() {
        userDefault.removeObject(forKey: userSessionKey)
    }
}

