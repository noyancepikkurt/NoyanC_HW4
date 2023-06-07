//
//  SplashRouter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import Reachability

enum SplashRoutes {
    case tabBar
}

protocol SplashRouterProtocol: AnyObject {
    func navigate(_ route: SplashRoutes)
}

final class SplashRouter {
    
    weak var viewController: SplashViewController?
    
    static func createModule() -> SplashViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SplashRouter: SplashRouterProtocol {
    
    func navigate(_ route: SplashRoutes) {
        switch route {
        case .tabBar:
            guard let window = UIApplication.shared.windows.first else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            let searchController = SearchRouter.createModule()
            tabBarController.setViewControllers([homeVC,searchController], animated: true)
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}

