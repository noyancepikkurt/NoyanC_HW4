//
//  MockSearchRouter.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import Foundation
@testable import NoyanC_HW4

final class MockSearchRouter: SearchRouterProtocol {
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: SearchRoutes, Void)?
    
    func navigate(_ route: SearchRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
}
