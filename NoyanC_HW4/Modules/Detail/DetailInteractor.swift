//
//  DetailInteractor.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import SongAPI
import CoreData

protocol DetailInteractorProtocol: AnyObject {
    func saveOrDelete(_ model: SongDetail)
}

final class DetailInteractor {
    var coreDataModel: SongEntity?
}

extension DetailInteractor: DetailInteractorProtocol {
    func saveOrDelete(_ model: SongDetail) {
        CoreDataManager.shared.saveOrDelete(model)
    }
}
