//
//  HomePresenterTests.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import XCTest
import SongAPI
@testable import NoyanC_HW4

final class HomePresenterTests: XCTestCase {
    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!
    
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
    
    func test_viewDidLoad_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedRegisterCollectionView)
        XCTAssertEqual(view.invokedRegisterCollectionViewCount, 0)
        XCTAssertFalse(interactor.isInvokedFetchSongs)
        XCTAssertEqual(interactor.invokedFetchSongsCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedRegisterCollectionView)
        XCTAssertEqual(view.invokedRegisterCollectionViewCount, 1)
        XCTAssertTrue(interactor.isInvokedFetchSongs)
        XCTAssertEqual(interactor.invokedFetchSongsCount, 1)
    }
    
    func test_fetchSongOutput() {
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertFalse(view.isInvokedReloadData)
        XCTAssertFalse(view.isInvokedShowLoading)
        
        presenter.fetchSongsOutput(.success(.responseHome))
        
        XCTAssertTrue(view.isInvokedHideLoading)
        XCTAssertEqual(presenter.numberOfItems(), 50)
        XCTAssertTrue(view.isInvokedReloadData)
    }
}

extension SongModel {
    static var responseHome: SongModel {
        let bundle = Bundle(for: HomePresenterTests.self)
        let path = bundle.path(forResource: "Song", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SongModel.self, from: data)
        return response
    }
}
