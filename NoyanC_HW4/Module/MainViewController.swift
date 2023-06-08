//
//  MainViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit

final class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTabBarAppearance()
        addTabbarItem()
    }
    
    private func addTabbarItem() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeVC = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.homeVC.rawValue) as! HomeViewController
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        
        let searchVC = SearchRouter.createModule()
        
        let favoritesVC = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.favoritesVC.rawValue) as! FavoritesViewController
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesVC)
        
        self.viewControllers = [homeNavigationController, searchVC, favoritesNavigationController]
    }
    
    private func customizeTabBarAppearance() {
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.systemGray
    }
}
