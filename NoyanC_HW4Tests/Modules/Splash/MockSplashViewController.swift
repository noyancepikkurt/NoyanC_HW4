//
//  MockSplashViewController.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import Foundation
@testable import NoyanC_HW4

final class MockSplashViewController: SplashViewControllerProtocol {
    var isInvokedNoInternetConnection = false
    var invokedNoInternetConnectionCount = 0
    
    func noInternetConnection() {
        isInvokedNoInternetConnection = true
        invokedNoInternetConnectionCount += 1
    }
}
