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
    func deleteFavorites(_ index: Int)
}

final class FavoritesPresenter {
    unowned var view: FavoritesViewControllerProtocol?
    let interactor: FavoritesInteractorProtocol!
    
    private var songsModel: [SongEntity] = []
    
    init(view: FavoritesViewControllerProtocol,
         interactor: FavoritesInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func deleteFavorites(_ index: Int) {
        CoreDataManager.shared.deleteSongEntity(withTrackID: songsModel[index].trackID!)
        songsModel.remove(at: index)
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        fetchFromCoreData()
    }
    
    func numberOfItem() -> Int {
        songsModel.count
    }
    
    func songs(_ index: Int) -> SongEntity? {
        return songsModel[index]
    }
    
    private func fetchFromCoreData() {
        interactor.fetchDatas()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    func fetchDatasOutput(_ result: [SongEntity]) {
        self.songsModel = result
        view?.reloadData()
    }
}

