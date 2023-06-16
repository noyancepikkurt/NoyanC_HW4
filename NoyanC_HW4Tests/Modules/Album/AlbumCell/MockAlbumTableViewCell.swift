//
//  MockAlbumTableViewCell.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 16.06.2023.
//

import UIKit
@testable import NoyanC_HW4

final class MockAlbumTableViewCell: AlbumTableViewCellProtocol {
    var isInvokedSetImage = false
    var invokedSetImageCount = 0
    
    func setImage(_ image: UIImage) {
        isInvokedSetImage = true
        invokedSetImageCount += 1
    }
    
    var isInvokedSetSongName = false
    var invokedSetSongNameCount = 0
    
    func setSongName(_ text: String) {
        isInvokedSetSongName = true
        invokedSetSongNameCount += 1
    }
    
    var isInvokedSetArtistName = false
    var invokedSetArtistNameCount = 0
    
    func setArtistName(_ text: String) {
        isInvokedSetArtistName = true
        invokedSetArtistNameCount += 1
    }
    
    var isInvokedShowIndicator = false
    var invokedShowIndicatorCount = 0
    
    func showIndicator() {
        isInvokedShowIndicator = true
        invokedShowIndicatorCount += 1
    }
    
    var isInvokedHideIndicator = false
    var invokedHideIndicatorCount = 0
    
    func hideIndicator() {
        isInvokedHideIndicator = true
        invokedHideIndicatorCount += 1
    }
}
