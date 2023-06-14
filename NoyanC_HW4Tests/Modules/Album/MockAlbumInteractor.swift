//
//  MockAlbumInteractor.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import Foundation
@testable import NoyanC_HW4

final class MockAlbumInteractor: AlbumInteractorProtocol {
    var isInvokedFetchSongs = false
    var invokedFetchSongsCount = 0
    
    func fetchAlbumSongs() {
        isInvokedFetchSongs = true
        invokedFetchSongsCount += 1
    }
}
