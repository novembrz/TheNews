//
//  NewsFeedViewModel.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import Foundation
import RealmSwift

protocol NewsFeedViewModelType {
    var newsItem: [NewsModel] {get set}
    var currentSource: SourceModel {get set}
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsFeedCellViewModelType?
}

class NewsFeedViewModel: NewsFeedViewModelType {
    
    var newsItem: [NewsModel] = []
    
    var currentSource: SourceModel = SourceModel(title: "Новости Banki.ru", url: CurrentURL.getBankiURlString())
    
    func numberOfRows() -> Int {
        return newsItem.count 
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsFeedCellViewModelType? {
        let news = newsItem[indexPath.row]
        return NewsFeedCellViewModel(newsItem: news)
    }
    
}
