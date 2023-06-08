//
//  DetailInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import Foundation
import SongAPI
import CoreData

typealias CoreDataResult = Result<[SongEntity], Error>

protocol DetailInteractorProtocol {
    func save(_ model: SongDetail)
    func delete(_ model: SongEntity)
    func fetch()
}

protocol DetailInteractorOutputProtocol {
    func saveCoreData(_ saveResult: SongEntity )
//    func deleteCoreData(_ deleteResult: SongDetail)
    func fetchCoreData(_ fetchResult: CoreDataResult )
}

final class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
    var coreDataModel: SongEntity?
}

extension DetailInteractor: DetailInteractorProtocol {
    func fetch() {
        CoreDataManager.shared.fetchNew { result in
            self.output?.fetchCoreData(result)
        }
    }
    
    func save(_ model: SongDetail) {
        CoreDataManager.shared.saveNew(model: model, isFavorite: true) { result in
            switch result {
            case .success(_):
                CoreDataManager.shared.fetchNew { result in
                    switch result {
                    case .success(let models):
                        for model in models {
                            self.coreDataModel = model
                        }
                    case .failure(_):
                        break
                    }
                    self.output?.saveCoreData(self.coreDataModel!)
                }
            case .failure(_):
                break
            }
        }
    }
    
    func delete(_ model: SongEntity) {
        CoreDataManager.shared.deleteNew(model: model) { result in
            switch result {
            case .success(_):
                print(" \(String(describing: model.artistName))silindi")
            case .failure(_):
                break
            }
        }
    }
}
