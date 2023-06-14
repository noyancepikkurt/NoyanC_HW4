//
//  MockSearchViewController.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import Foundation
@testable import NoyanC_HW4

final class MockSearchViewController: SearchViewControllerProtocol {
    var isInvokedSetupTableView = false
    var invokedSetupTableViewCount = 0
    
    func setupTableView() {
        isInvokedSetupTableView = true
        invokedSetupTableViewCount += 1
    }
    
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        isInvokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    var isInvokedShowError = false
    var invokedShowErrorCount = 0
    
    func showError(_ message: String) {
        isInvokedShowError = true
        invokedShowErrorCount += 1
    }
}
