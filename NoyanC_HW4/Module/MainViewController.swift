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
        
        let homeVC = HomeRouter.createModule()
        
        let searchVC = SearchRouter.createModule()
        
        let favoritesVC = FavoritesRouter.createModule()
        
        self.viewControllers = [homeVC, searchVC, favoritesVC]
    }
    
    private func customizeTabBarAppearance() {
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.systemGray
    }
}
