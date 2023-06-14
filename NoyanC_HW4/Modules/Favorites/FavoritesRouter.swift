//
//  FavoritesRouter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import UIKit
import CoreData
import SongAPI

protocol FavoritesRouterProtocol { }

final class FavoritesRouter {
    weak var viewController: FavoritesViewController?
    
    static func createModule() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.favoritesVC.rawValue) as! FavoritesViewController
        let router = FavoritesRouter()
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        let favoritesNavigationController = UINavigationController(rootViewController: view)
        return favoritesNavigationController
    }
}

extension FavoritesRouter: FavoritesRouterProtocol { }
