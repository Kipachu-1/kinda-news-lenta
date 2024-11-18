//
//  NavigationBar.swift
//  kinda-news-lenta
//
//  Created by Arsen Kipachu on 11/18/24.
//

import UIKit

class NavigationBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeVC = NewsListViewController()
        let likesVC = LikedNewsListViewController() // Placeholder for search
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        likesVC.tabBarItem = UITabBarItem(
            title: "Likes",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let likesNav = UINavigationController(rootViewController: likesVC)
        
        setViewControllers([homeNav, likesNav], animated: false)
        
        // Customize tab bar appearance
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemBackground
        customizeTabBarAppearance()
    }
    
    func customizeTabBarAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
        
        // Custom tint colors
        tabBar.tintColor = .systemBlue // Selected item color
        tabBar.unselectedItemTintColor = .gray // Unselected item color
    }
    
//    func setupNavigationBar() {
//        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(todayTapped))
//        
//        let myLikesButton = UIBarButtonItem(title: "My Likes", style: .plain, target: self, action: #selector(myLikesTapped))
//        
//        navigationItem.leftBarButtonItem = todayButton
//        navigationItem.rightBarButtonItem = myLikesButton
//    }
//    
//    @objc func todayTapped() {
//        print("Today button tapped!")
//        // Navigate to the Today screen or update the view
//    }
//    
//    @objc func myLikesTapped() {
//        print("My Likes button tapped!")
//        // Navigate to the My Likes screen or update the view
//    }
}
