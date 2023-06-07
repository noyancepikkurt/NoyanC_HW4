//
//  SearchRouter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import SongAPI

protocol SearchRouterProtocol {
    func navigate(_ route: SearchRoutes)
}

enum SearchRoutes {
    case detail(source: SongDetail?)
}

final class SearchRouter {
    
    weak var viewController: SearchViewController?
    
    static func createModule() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}

extension SearchRouter: SearchRouterProtocol {
    
    func navigate(_ route: SearchRoutes) {
        switch route {
        case .detail(let source):
            let detailVC = DetailRouter.createModule()
            detailVC.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
