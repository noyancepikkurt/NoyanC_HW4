//
//  FavoritesInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import Foundation
import CoreData

protocol FavoritesInteractorProtocol: AnyObject {
    func fetchDatas()
}

protocol FavoritesInteractorOutputProtocol {
    func fetchDatasOutput(_ result: [SongEntity])
}

final class FavoritesInteractor {
    var output: FavoritesInteractorOutputProtocol?
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    func fetchDatas() {
        CoreDataManager.shared.fetchSongs { result in
            switch result {
            case .success(let success):
                self.output?.fetchDatasOutput(success)
            case .failure(_):
                break
            }
        }
    }
}
