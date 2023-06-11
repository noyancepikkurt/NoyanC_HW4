//
//  AlbumRouter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import UIKit
import SongAPI

protocol AlbumRouterProtocol {
    func navigate(_ route: AlbumRoutes)
}

enum AlbumRoutes {
    case detail(source: SongDetail?)
}

final class AlbumRouter {
    private weak var viewController: UIViewController?
    
    static func createModule() -> AlbumViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.albumVC.rawValue) as! AlbumViewController
        let interactor = AlbumInteractor()
        let router = AlbumRouter()
        let presenter = AlbumPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension AlbumRouter: AlbumRouterProtocol {
    func navigate(_ route: AlbumRoutes) {
        switch route {
        case .detail(let source):
            let detailVC = DetailRouter.createModule()
            detailVC.presenter.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
