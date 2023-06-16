//
//  MockDetailViewController.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 15.06.2023.
//

import UIKit
@testable import NoyanC_HW4

final class MockDetailViewController: DetailViewControllerProtocol {
    var isInvokedSetSongTitle = false
    var invokedSetSongTitleCount = 0
    
    func setSongTitle(_ text: String) {
        isInvokedSetSongTitle = true
        invokedSetSongTitleCount += 1
    }
    
    var isInvokedSetSongArtistName = false
    var invokedSetSongArtistNameCount = 0
    
    func setSongArtistName(_ text: String) {
        isInvokedSetSongArtistName = true
        invokedSetSongArtistNameCount += 1
    }
    
    var isInvokedSetSongKindName = false
    var invokedSetSongKindNameCount = 0
    
    func setSongKindName(_ text: String) {
        isInvokedSetSongKindName = true
        invokedSetSongKindNameCount += 1
    }
    
    var isInvokedSetSongImage = false
    var invokedSetSongImageCount = 0
    
    func setSongImage(_ image: UIImage) {
        isInvokedSetSongImage = true
        invokedSetSongImageCount += 1
    }
    
    var isInvokedSetSongTrackPrice = false
    var invokedSetSongTrackPriceCount = 0
    
    func setSongTrackPrice(_ text: String) {
        isInvokedSetSongTrackPrice = true
        invokedSetSongTrackPriceCount += 1
    }
    
    var isInvokedSetSongCollectionPrice = false
    var invokedSetSongCollectionPriceCount = 0
    
    func setSongCollectionPrice(_ text: String) {
        isInvokedSetSongCollectionPrice = true
        invokedSetSongCollectionPriceCount += 1
    }
    
    var isInvokedUpdateButton = false
    var invokedUpdateButtonCount = 0
    
    func updateButton() {
        isInvokedUpdateButton = true
        invokedUpdateButtonCount += 1
    }
    
    var isInvokedSetupVideoImage = false
    var invokedSetupVideoImageCount = 0
    
    func setupVideoImage(_ isThereVideoURL: Bool) {
        isInvokedSetupVideoImage = true
        invokedSetupVideoImageCount += 1
    }
    
    var isInvokedHideLoading = false
    var invokedHideLoadingCount = 0
    
    func hideLoadingView() {
        isInvokedHideLoading = true
        invokedHideLoadingCount += 1
    }
}
