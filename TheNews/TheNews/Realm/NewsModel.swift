//
//  NewsModel.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import Foundation
import RealmSwift

class NewsModel: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var date = ""
    @objc dynamic var desc = ""
    @objc dynamic var isReading = false
    @objc dynamic var isFavourite = false
    
    convenience init(title: String, date: String, desc: String, isReading: Bool, isFavourite: Bool) {
        self.init()
        self.title = title
        self.date = date
        self.desc = desc
        self.isReading = isReading
        self.isFavourite = isFavourite
    }
}
