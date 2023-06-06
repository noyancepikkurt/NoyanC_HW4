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
    
    static func createModule() -> SearchViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        presenter.viewDidLoad() // presenter'ın viewDidLoad() fonksiyonunu çağırın
        view.presenter = presenter // presenter'ı view'e atayın
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SearchRouter: SearchRouterProtocol {
    
    func navigate(_ route: SearchRoutes) {
        switch route {
        case .detail(let source):
            
            //            let detailVC = DetailRouter.createModule()
            //            detailVC.source = source
            viewController?.navigationController?.pushViewController(DetailViewController(), animated: true)
        }
    }
}
