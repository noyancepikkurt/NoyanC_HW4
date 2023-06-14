//
//  MockHomeInteractor.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import Foundation
@testable import NoyanC_HW4

final class MockHomeInteractor: HomeInteractorProtocol {
    var isInvokedFetchSongs = false
    var invokedFetchSongsCount = 0
    
    func fetchSongs() {
        isInvokedFetchSongs = true
        invokedFetchSongsCount += 1
    }
}
