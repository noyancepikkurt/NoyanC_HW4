//
//  AlbumCellPresenterTests.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 16.06.2023.
//

import XCTest
import SongAPI
@testable import NoyanC_HW4

final class AlbumCellPresenterTests: XCTestCase {
    var view: MockAlbumTableViewCell!
    var presenter: AlbumCellPresenter!
    
    override func setUp() {
        super.setUp()
        view = .init()
        presenter = .init(view: view, songDetail: SongModel.responseAlbumCell.results![0])
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
        XCTAssertFalse(view.isInvokedShowIndicator)
        XCTAssertEqual(view.invokedShowIndicatorCount, 0)
        
        presenter.load()
        
        XCTAssertTrue(view.isInvokedSetSongName)
        XCTAssertEqual(view.invokedSetSongNameCount, 1)
        XCTAssertTrue(view.isInvokedSetArtistName)
        XCTAssertEqual(view.invokedSetArtistNameCount, 1)
        XCTAssertTrue(view.isInvokedShowIndicator)
        XCTAssertEqual(view.invokedShowIndicatorCount, 1)
    }
}

extension SongModel {
    static var responseAlbumCell: SongModel {
        let bundle = Bundle(for: AlbumCellPresenterTests.self)
        let path = bundle.path(forResource: "Song", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SongModel.self, from: data)
        return response
    }
}
