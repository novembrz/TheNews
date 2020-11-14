//
//  NewsViewController.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import UIKit

class NewsViewController: UIViewController {
    
    var newsItem: NewsModel?
    private let newsView = NewsView()
    
    var closure: ((NewsModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        updateInfo(news: newsItem!)
        createUI()
    }
    
    
    private func updateInfo(news: NewsModel?){
        guard let title = news?.title,
              let date = news?.date,
              let description = news?.desc else { return }
        
        newsView.titleLabel.text = title
        newsView.dateLabel.text = date.formattedDate
        newsView.descTextView.text = removeHTMLTags(from: description)
    }
    
    
    private func removeHTMLTags(from str: String) -> String {
        let test = str
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&[^;]+;", with:
                                    "", options:.regularExpression, range: nil)
        return test
    }
    
    
    private func createUI() {
        
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let navBarHeight = statusBarHeight + (navigationController?.navigationBar.frame.height ?? 0)
        
        newsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(newsView)
        
        NSLayoutConstraint.activate([
            newsView.topAnchor.constraint(equalTo: view.topAnchor, constant: navBarHeight),
            newsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            newsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            newsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
}
