//
//  CurrentURL.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import Foundation

class CurrentURL {
    
    static func getBankiURlString() -> String {
        return "https://www.banki.ru/xml/news.rss"
    }
    
    static func getFinamURlString() -> String {
        return "https://www.finam.ru/net/analysis/conews/rsspoint"
    }
}
