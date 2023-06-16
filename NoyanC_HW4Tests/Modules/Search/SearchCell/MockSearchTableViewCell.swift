//
//  MockSearchTableViewCell.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 16.06.2023.
//

import UIKit
@testable import NoyanC_HW4

final class MockSearchTableViewCell: SearchCellProtocol {
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
    
    var isInvokedSetAlbumName = false
    var invokedSetAlbumNameCount = 0
    
    func setAlbumName(_ text: String) {
        isInvokedSetAlbumName = true
        invokedSetAlbumNameCount += 1
    }
    
    var isInvokedUpdateButton = false
    var invokedUpdateButtonCount = 0
    
    func updateButton() {
        isInvokedUpdateButton = true
        invokedUpdateButtonCount += 1
    }
    
    var isInvokedHideLoadingView = false
    var invokedHideLoadingViewCount = 0
    
    func hideLoadingView() {
        isInvokedHideLoadingView = true
        invokedHideLoadingViewCount += 1
    }
    
    var isInvokedSetupVideoImage = false
    var invokedSetupVideoImageCount = 0
    
    func setupVideoImage(_ isThereVideoURL: Bool) {
        isInvokedSetupVideoImage = true
        invokedSetupVideoImageCount += 1
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
