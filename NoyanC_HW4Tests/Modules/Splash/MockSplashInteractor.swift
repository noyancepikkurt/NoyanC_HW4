//
//  MockSplashInteractor.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import Foundation
@testable import NoyanC_HW4

final class MockSplashInteractor: SplashInteractorProtocol {
    var isInvokedCheckInternetConnection = false
    var invokedCheckInternetConnectionCount = 0
    
    func checkInternetConnection() {
        isInvokedCheckInternetConnection = true
        invokedCheckInternetConnectionCount += 1
    }
}
