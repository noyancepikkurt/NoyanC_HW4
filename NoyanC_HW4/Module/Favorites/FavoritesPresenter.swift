//
//  FavoritesPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import Foundation
import CoreData
import SongAPI

protocol FavoritesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItem() -> Int
    func songs(_ index: Int) -> SongEntity?
    func didSelectRowAt(index: Int)
}

final class FavoritesPresenter {
    
    var view: FavoritesViewControllerProtocol?
    let router: FavoritesRouterProtocol!
    let interactor: FavoritesInteractorProtocol!
    
    private var songs: [SongEntity] = []
    
    init(view: FavoritesViewControllerProtocol,
         router: FavoritesRouterProtocol,
         interactor: FavoritesInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func viewDidLoad() {
        view?.setupTableView()
        fetchFromCoreData()
    }
    
    func numberOfItem() -> Int {
        songs.count
    }
    
    func songs(_ index: Int) -> SongEntity? {
        return songs[index]
    }
    
    func didSelectRowAt(index: Int) {
       // -> detail vs
    }
    
    private func fetchFromCoreData() {
        interactor.fetchDatas()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    func fetchDatasOutput(_ result: [SongEntity]) {
        self.songs = result
        view?.reloadData()
    }
}

