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
    private var refreshControl = UIRefreshControl()
    
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
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        navigationItem.title = "Новости Banki.ru"
    }
    
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.pin(view: view)
        tableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.reuseId)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Потяните для обновления")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    
    private func updateTableView(){
        let feedParser = NewsParser()
        
        guard let url = viewModel?.currentSource.url else {return}
        refreshControl.beginRefreshing()
        print(url)
        
        feedParser.parseFeed(url: url) { (newsItem) in
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                for el in newsItem{
                    let realmItem = NewsModel(title: el.title, date: el.pudDate, desc: el.description, isReading: false, isFavourite: false)
                    self.viewModel?.newsItem.append(realmItem)
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        updateTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sourceVC = segue.destination as! SourceViewController
        sourceVC.delegate = self
    }
}


//MARK: UITableView Delegate & DataSource

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0 // newsFeed.count
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
        let news = viewModel.newsItem[indexPath.row]
        newsVC.newsItem = news
        
        RealmManager.makeItRead(editNews: news, newState: true)

        tableView.reloadData()
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
}

//MARK:- SourceListDataDelegate
extension NewsFeedViewController: SourceDelegate {
    func updateSource(source: SourceModel) {
        viewModel?.currentSource = source
        updateTableView()
    }
    
}
