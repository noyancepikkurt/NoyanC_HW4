//
//  MockSplashRouter.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import Foundation
@testable import NoyanC_HW4

final class MockSplashRouter: SplashRouterProtocol {
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: SplashRoutes, Void)?
    
    func navigate(_ route: NoyanC_HW4.SplashRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
}
