//
//  MockAlbumRouter.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import Foundation
@testable import NoyanC_HW4

final class MockAlbumRouter: AlbumRouterProtocol {
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: AlbumRoutes, Void)?
    
    func navigate(_ route: NoyanC_HW4.AlbumRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
}
