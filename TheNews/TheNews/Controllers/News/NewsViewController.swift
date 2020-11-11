//
//  NewsViewController.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import UIKit

class NewsViewController: UIViewController {
    
    var newsItem: NewsItem?
    private let newsView = NewsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        createUI()
    }
    
    private func createUI(){
        
        view.addSubview(newsView)
        newsView.pin(view: view)
        
    }


}
