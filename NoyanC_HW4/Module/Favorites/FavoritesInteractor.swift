//
//  FavoritesInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import Foundation
import CoreData

typealias SongsCoreDataResult = Result<SongEntity, Error>

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
        CoreDataManager.shared.fetchNew { result in
            switch result {
            case .success(let success):
                self.output?.fetchDatasOutput(success)
            case .failure(_):
                break
            }
        }
    }
    
    
}
