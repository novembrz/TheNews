//
//  RealmManager.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import Foundation
import RealmSwift

let realm = try! Realm()

struct RealmManager {
    
    static var news: Results<NewsModel> {
        return realm.objects(NewsModel.self)
    }
    
    static func saveObject(_ news: NewsModel) {
        try! realm.write {
            realm.add(news)
        }
    }
    
    static func saveAll(_ news: [NewsModel]) {
        try! realm.write {
            realm.add(news)
        }
    }
    
    static func deleteObject(_ news: NewsModel) {
        try! realm.write {
            realm.delete(news)
        }
    }
    
    static func deleteAll(_ news: Results<NewsModel>) {
        try! realm.write {
            realm.delete(news)
        }
    }
    
    static func deleteAllllll(){
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    static func makeItRead(editNews: NewsModel, newState: Bool){
        try! realm.write {
            editNews.isReading = newState
        }
    }
    
    static func makeItFavourite(editNews: NewsModel, newState: Bool){
        try! realm.write {
            editNews.isFavourite = newState
        }
    }
    
}
