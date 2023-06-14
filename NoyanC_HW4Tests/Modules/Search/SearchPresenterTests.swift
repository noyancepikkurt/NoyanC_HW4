//
//  SearchPresenterTests.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import XCTest
import SongAPI
@testable import NoyanC_HW4

final class SearchPresenterTests: XCTestCase {
    var presenter: SearchPresenter!
    var view: MockSearchViewController!
    var interactor: MockSearchInteractor!
    var router: MockSearchRouter!
    
    override  func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }
    
    override  func tearDown() {
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }

    func test_viewDidLoad_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 0)
        XCTAssertFalse(interactor.isInvokedFetchSongs)
        XCTAssertEqual(interactor.invokedFetchSongsCount, 0)
        
        presenter.viewDidLoad()
        presenter.fetchSongsFilter(with: SongModel.responseSearch.results![0].artistName!)
        
        XCTAssertTrue(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 1)
        XCTAssertTrue(interactor.isInvokedFetchSongs)
        XCTAssertEqual(interactor.invokedFetchSongsCount, 1)
    }
    
    func test_fetchSongOutput() {
        XCTAssertFalse(view.isInvokedShowError)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertFalse(view.isInvokedReloadData)
        
        presenter.fetchSongsOutput(.success(.responseSearch))
        
        XCTAssertFalse(view.isInvokedShowError)
        XCTAssertEqual(presenter.numberOfItems(), 50)
        XCTAssertTrue(view.isInvokedReloadData)
    }
}

extension SongModel {
    static var responseSearch: SongModel {
        let bundle = Bundle(for: SearchPresenterTests.self)
        let path = bundle.path(forResource: "Song", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SongModel.self, from: data)
        return response
    }
}


