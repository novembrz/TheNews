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
    var isReading: Bool  { get }
}


class NewsFeedCellViewModel: NewsFeedCellViewModelType {
    
    private var newsItem: NewsModel! //NewsItem!
    
    var title: String {
        return newsItem.title 
    }
    
    var date: String {
        return newsItem.date.formattedDate//newsItem.pudDate.formattedDate
    }
    
    var isReading: Bool {
        return newsItem.isReading
    }
    
    
    init(newsItem: NewsModel){
        self.newsItem = newsItem
    }
}
