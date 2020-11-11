//
//  NewsFeedViewController.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    var viewModel: NewsFeedViewModelType?
    private var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = NewsFeedViewModel()
        
        view.backgroundColor = .white
        
        setupTableView()
        setupNavigationBar()
        updateTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Новости Banki.ru"
    }
    
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.pin(view: view)
        tableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.reuseId)
    }
    
    
    private func updateTableView(){
        let feedParser = NewsParser()
        feedParser.parseFeed(url: viewModel?.currentSource.url ?? CurrentURL.getBankiURlString()) { (newsItem) in
            
            self.viewModel?.newsItem = newsItem
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
}


//MARK: UITableView Delegate & DataSource

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as? NewsFeedCell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        
        let newsVC = NewsViewController()
        var news = viewModel.newsItem[indexPath.row]
        newsVC.newsItem = news
        news.isReading = true
        
        tableView.reloadData()
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
}
