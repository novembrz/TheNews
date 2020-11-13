//
//  FavouritesViewModel.swift
//  TheNews
//
//  Created by Дарья on 12.11.2020.
//

import Foundation

protocol FavouritesViewModelType {
    var newsItem: [NewsModel] {get set}
    var item: NewsModel {get set}
    var reloadModelClosure: (() ->())? {get set}
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsFeedCellViewModelType?
}

class FavouritesViewModel: FavouritesViewModelType {
    
    var newsItem: [NewsModel] = []
    
    var item = NewsModel(){
        didSet {
            self.reloadModelClosure?()
        }
    }
    
    var reloadModelClosure: (() ->())?
    
    func numberOfRows() -> Int {
        return newsItem.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsFeedCellViewModelType? {
        let news = newsItem[indexPath.row]
        return NewsFeedCellViewModel(newsItem: news)
    }
}
