//
//  FavouritesViewController.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    var viewModel: FavouritesViewModelType?
    private var tableView = UITableView()
    
    var news = RealmManager.news

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        viewModel = FavouritesViewModel()
        setupTableView()
        setupNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        news = realm.objects(NewsModel.self)
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        navigationItem.title = "Сохраненные"
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.pin(view: view)
        tableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.reuseId)
    }

}


//MARK: UITableView Delegate & DataSource

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count//viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as? NewsFeedCell, let viewModel = viewModel else { return UITableViewCell() }
        
//        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
//        cell.viewModel = cellViewModel
        
        cell.titleLabel.text = news[indexPath.row].title
        cell.dateLabel.text = news[indexPath.row].date
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        guard let viewModel = viewModel else { return }
//
//        let newsVC = NewsViewController()
//        let news = viewModel.newsItem[indexPath.row]
//        newsVC.newsItem = news
//
//        RealmManager.makeItRead(editNews: news, newState: true)
//
//        tableView.reloadData()
//        self.navigationController?.pushViewController(newsVC, animated: true)
//    }
}
