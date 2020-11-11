//
//  MainTabBarController.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newsFeedViewController = NewsFeedViewController()
        let favouritesViewController = FavouritesViewController()
        let sourceViewController = SourceViewController()
        
        tabBar.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        
        let newsFeedImage = UIImage(systemName: "n.circle.fill", withConfiguration: boldConfiguration)!
        let favImage = UIImage(systemName: "bookmark", withConfiguration: boldConfiguration)!
        let sourceImage = UIImage(systemName: "book", withConfiguration: boldConfiguration)!
        
        viewControllers = [
            generateNavigationController(rootViewController: favouritesViewController, title: "Favourites", image: favImage),
            generateNavigationController(rootViewController: newsFeedViewController, title: "NewsFeed", image: newsFeedImage),
            generateNavigationController(rootViewController: sourceViewController, title: "Source", image: sourceImage)
        ]
        
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}
