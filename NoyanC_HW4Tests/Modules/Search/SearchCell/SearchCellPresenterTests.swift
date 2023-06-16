//
//  SearchCellPresenterTests.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 16.06.2023.
//

import XCTest
import SongAPI
@testable import NoyanC_HW4

final class SearchCellPresenterTests: XCTestCase {
    var view: MockSearchTableViewCell!
    var presenter: SearchCellPresenter!
    
    override func setUp() {
        super.setUp()
        view = .init()
        presenter = .init(view: view, song: SongModel.responseSearchCell.results![0])
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
    }
    
    func test_load_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedSetSongName)
        XCTAssertEqual(view.invokedSetSongNameCount, 0)
        XCTAssertFalse(view.isInvokedSetArtistName)
        XCTAssertEqual(view.invokedSetArtistNameCount, 0)
        XCTAssertFalse(view.isInvokedSetAlbumName)
        XCTAssertEqual(view.invokedSetAlbumNameCount, 0)
        XCTAssertFalse(view.isInvokedSetAlbumName)
        XCTAssertEqual(view.invokedSetAlbumNameCount, 0)
        XCTAssertFalse(view.isInvokedSetupVideoImage)
        XCTAssertEqual(view.invokedSetupVideoImageCount, 0)
        XCTAssertFalse(view.isInvokedShowIndicator)
        XCTAssertEqual(view.invokedShowIndicatorCount, 0)
        
        presenter.load()
        
        XCTAssertTrue(view.isInvokedSetSongName)
        XCTAssertEqual(view.invokedSetSongNameCount, 1)
        XCTAssertTrue(view.isInvokedSetArtistName)
        XCTAssertEqual(view.invokedSetArtistNameCount, 1)
        XCTAssertTrue(view.isInvokedSetAlbumName)
        XCTAssertEqual(view.invokedSetAlbumNameCount, 1)
        XCTAssertTrue(view.isInvokedSetAlbumName)
        XCTAssertEqual(view.invokedSetAlbumNameCount, 1)
        XCTAssertTrue(view.isInvokedSetupVideoImage)
        XCTAssertEqual(view.invokedSetupVideoImageCount, 1)
        XCTAssertTrue(view.isInvokedShowIndicator)
        XCTAssertEqual(view.invokedShowIndicatorCount, 1)
    }
}

extension SongModel {
    static var responseSearchCell: SongModel {
        let bundle = Bundle(for: SearchPresenterTests.self)
        let path = bundle.path(forResource: "Song", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SongModel.self, from: data)
        return response
    }
}
