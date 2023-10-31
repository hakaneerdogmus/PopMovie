//
//  TabBarViewController.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 25.09.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeView = HomeView()
        let favoriteView = FavoriteViewController()
        let tabBarController = [homeView, favoriteView]
        
        homeView.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film.stack"), selectedImage: UIImage(systemName: "film.stack.fill"))
        favoriteView.tabBarItem = UITabBarItem(title: "Fav", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        
        self.viewControllers = tabBarController
       
            
        navigationItem.hidesBackButton = true

    }
    

}
