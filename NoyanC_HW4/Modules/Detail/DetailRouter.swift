//
//  DetailRouter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit

final class DetailRouter {
    weak var viewController: DetailViewController?
    
    static func createModule() -> DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifiers.detailVC.rawValue) as! DetailViewController
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(view: view, interactor: interactor)
        view.presenter = presenter
        return view
    }
}
