//
//  DetailRouter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit

protocol DetailRouterProtocol {
    
}

final class DetailRouter {
    
    weak var viewController: DetailViewController?

    static func createModule() -> DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.detailVC.rawValue) as! DetailViewController
        let router = DetailRouter()
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        router.viewController = view
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    
}
