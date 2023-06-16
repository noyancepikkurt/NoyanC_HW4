//
//  AlbumPresenterTests.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 14.06.2023.
//

import XCTest
import SongAPI
@testable import NoyanC_HW4

final class AlbumPresenterTests: XCTestCase {
    var presenter: AlbumPresenter!
    var view: MockAlbumViewController!
    var interactor: MockAlbumInteractor!
    var router: MockAlbumRouter!
    
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
        XCTAssertFalse(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 0)
        XCTAssertFalse(interactor.isInvokedFetchSongs)
        XCTAssertEqual(interactor.invokedFetchSongsCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 1)
        XCTAssertTrue(interactor.isInvokedFetchSongs)
        XCTAssertEqual(interactor.invokedFetchSongsCount, 1)
    }
    
    func test_fetchSongOutput() {
        XCTAssertEqual(presenter.numberOfItem(), 0)
        XCTAssertFalse(view.isInvokedReloadData)
        
        presenter.fetchAlbumSongsOutput(.success(.response))
        
        XCTAssertEqual(presenter.numberOfItem(), 50)
        XCTAssertTrue(view.isInvokedReloadData)
    }
}

extension SongModel {
    static var response: SongModel {
        let bundle = Bundle(for: AlbumPresenterTests.self)
        let path = bundle.path(forResource: "Song", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SongModel.self, from: data)
        return response
    }
}
