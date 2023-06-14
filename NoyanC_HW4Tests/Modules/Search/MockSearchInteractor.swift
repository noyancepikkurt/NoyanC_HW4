//
//  MockSearchInteractor.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import Foundation
@testable import NoyanC_HW4

final class MockSearchInteractor: SearchInteractorProtocol {
    var isInvokedFetchSongs = false
    var invokedFetchSongsCount = 0
    
    func fetchSongs(_ word: String) {
        isInvokedFetchSongs = true
        invokedFetchSongsCount += 1
    }
}
