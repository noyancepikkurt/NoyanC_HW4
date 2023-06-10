//
//  AlbumPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import Foundation

protocol AlbumPresenterProtocol {
    
}

final class AlbumPresenter {
    
    weak var view: AlbumViewControllerProtocol?
    let router: AlbumRouterProtocol!
    let interactor: AlbumInteractorProtocol!
    
    init(view: AlbumViewControllerProtocol,
         router: AlbumRouterProtocol,
         interactor: AlbumInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension AlbumPresenter: AlbumPresenterProtocol {
    
}

extension AlbumPresenter: AlbumInteractorOutputProtocol {
    
}
