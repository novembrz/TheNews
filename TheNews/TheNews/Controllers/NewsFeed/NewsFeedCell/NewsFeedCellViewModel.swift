//
//  NewsFeedCellViewModel.swift
//  TheNews
//
//  Created by Дарья on 12.11.2020.
//

import Foundation

protocol NewsFeedCellViewModelType: class {
    var title: String { get }
    var date: String { get }
}


class NewsFeedCellViewModel: NewsFeedCellViewModelType {
    
    private var newsItem: NewsItem!
    
    var title: String {
        return newsItem.title 
    }
    
    var date: String {
        return newsItem.pudDate.formattedDate 
    }
    
    
    init(newsItem: NewsItem){
        self.newsItem = newsItem
    }
}
