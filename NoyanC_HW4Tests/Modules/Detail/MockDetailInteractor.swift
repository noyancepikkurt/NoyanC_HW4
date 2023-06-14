//
//  MockDetailInteractor.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 15.06.2023.
//

import Foundation
import SongAPI
@testable import NoyanC_HW4

final class MockDetailInteractor: DetailInteractorProtocol {
    var isInvokedSaveOrDelete = false
    var invokedSaveOrDeleteCount = 0
    
    func saveOrDelete(_ model: SongDetail) {
        isInvokedSaveOrDelete = true
        invokedSaveOrDeleteCount += 1
    }
}
