//
//  DetailPresenterTests.swift
//  NoyanC_HW4Tests
//
//  Created by Noyan Çepikkurt on 15.06.2023.
//

import XCTest
import SongAPI
@testable import NoyanC_HW4

final class DetailPresenterTests: XCTestCase {
    var presenter: DetailPresenter!
    var view: MockDetailViewController!
    var interactor: MockDetailInteractor!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        presenter = .init(view: view, interactor: interactor)
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        presenter = nil
    }
    
    private func viewDidLoad() {
        view.setSongTitle(SongModel.responseDetail.results![0].trackName!)
        view.setSongArtistName(SongModel.responseDetail.results![0].artistName!)
        view.setSongKindName(SongModel.responseDetail.results![0].kind!)
        view.setSongTrackPrice("\(SongModel.responseDetail.results![0].trackPrice!)")
        view.setSongCollectionPrice("\(SongModel.responseDetail.results![0].collectionPrice!)")
    }
    
    func test_viewDidLoad_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 0)
        XCTAssertFalse(view.isInvokedSetSongArtistName)
        XCTAssertEqual(view.invokedSetSongArtistNameCount, 0)
        XCTAssertFalse(view.isInvokedSetSongKindName)
        XCTAssertEqual(view.invokedSetSongKindNameCount, 0)
        XCTAssertFalse(view.isInvokedSetSongImage)
        XCTAssertEqual(view.invokedSetSongImageCount, 0)
        XCTAssertFalse(view.isInvokedSetSongTrackPrice)
        XCTAssertEqual(view.invokedSetSongTrackPriceCount, 0)
        XCTAssertFalse(view.isInvokedSetSongCollectionPrice)
        XCTAssertEqual(view.invokedSetSongCollectionPriceCount, 0)
        XCTAssertFalse(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 0)
        XCTAssertFalse(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 0)
        XCTAssertFalse(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 0)
        XCTAssertFalse(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 0)
        XCTAssertFalse(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 0)
        
        viewDidLoad()
        
        XCTAssertTrue(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 1)
        XCTAssertTrue(view.isInvokedSetSongArtistName)
        XCTAssertEqual(view.invokedSetSongArtistNameCount, 1)
        XCTAssertTrue(view.isInvokedSetSongKindName)
        XCTAssertEqual(view.invokedSetSongKindNameCount, 1)
        XCTAssertTrue(view.isInvokedSetSongTrackPrice)
        XCTAssertEqual(view.invokedSetSongTrackPriceCount, 1)
        XCTAssertTrue(view.isInvokedSetSongCollectionPrice)
        XCTAssertEqual(view.invokedSetSongCollectionPriceCount, 1)
        XCTAssertTrue(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 1)
        XCTAssertTrue(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 1)
        XCTAssertTrue(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 1)
        XCTAssertTrue(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 1)
        XCTAssertTrue(view.isInvokedSetSongTitle)
        XCTAssertEqual(view.invokedSetSongTitleCount, 1)
    }
}

extension SongModel {
    static var responseDetail: SongModel {
        let bundle = Bundle(for: DetailPresenterTests.self)
        let path = bundle.path(forResource: "Song", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SongModel.self, from: data)
        return response
    }
}
