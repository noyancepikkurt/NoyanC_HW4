//
//  SplashPresenterTests.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import XCTest
@testable import NoyanC_HW4

final class SplashPresenterTests: XCTestCase {
    var presenter: SplashPresenter!
    var view: MockSplashViewController!
    var interactor: MockSplashInteractor!
    var router: MockSplashRouter!

    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }

    
    func test_checkThereIsInternetConnection() {
        XCTAssertFalse(view.isInvokedNoInternetConnection)
        XCTAssertEqual(view.invokedNoInternetConnectionCount, 0)
        XCTAssertFalse(interactor.isInvokedCheckInternetConnection)
        XCTAssertEqual(interactor.invokedCheckInternetConnectionCount, 0)

        presenter.viewDidAppear()
        presenter.internetConnection(status: true)
        
        XCTAssertFalse(view.isInvokedNoInternetConnection)
        XCTAssertEqual(view.invokedNoInternetConnectionCount, 0)
        XCTAssertTrue(interactor.isInvokedCheckInternetConnection)
        XCTAssertEqual(interactor.invokedCheckInternetConnectionCount, 1)
    }
    
    func test_checkThereIsNoInternetConnection() {
        XCTAssertFalse(view.isInvokedNoInternetConnection)
        XCTAssertEqual(view.invokedNoInternetConnectionCount, 0)
        XCTAssertFalse(interactor.isInvokedCheckInternetConnection)
        XCTAssertEqual(interactor.invokedCheckInternetConnectionCount, 0)

        presenter.internetConnection(status: false)
        
        XCTAssertTrue(view.isInvokedNoInternetConnection)
        XCTAssertEqual(view.invokedNoInternetConnectionCount, 1)
        XCTAssertFalse(interactor.isInvokedCheckInternetConnection)
        XCTAssertEqual(interactor.invokedCheckInternetConnectionCount, 0)
    }
}
