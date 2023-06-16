
//
//  NoyanC_HW4UITests.swift
//  NoyanC_HW4UITests
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import XCTest

final class NoyanC_HW4UITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("********** UITest Launching **********")
    }
    
    private func searchSongOnKeyboard(_ songName: String) {
        app.textFields.firstMatch.typeText(songName)
        app.keyboards.buttons["Geç"].tap()
    }
    
    private func toSearchTextField() {
        app.launch()
        let tabBar = app.tabBars["Tab Bar"]
        let searchButton = tabBar.buttons["Search"]
        searchButton.tap()
        app.textFields["Artist, Song, Album"].tap()
    }
    
    func test_home_view_controller_to_album_songs() throws {
        app.launch()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element(boundBy: 0).cells.children(matching: .other).element.tap()
        app.tables.cells.containing(.staticText, identifier:"Beni Sen İnandır").staticTexts["Pinhani"].tap()
        app.navigationBars["NoyanC_HW4.DetailView"].buttons["Back"].tap()
        app.navigationBars["NoyanC_HW4.AlbumView"].buttons["Back"].tap()
    }
    
    func test_home_view_controller_to_search_songs() throws {
        toSearchTextField()
        searchSongOnKeyboard("Tarkan")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single"]/*[[".cells.staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]",".staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["NoyanC_HW4.DetailView"].buttons["Back"].tap()
    }
    
    func test_add_favorite_song_from_detail_view_controller() throws {
        toSearchTextField()
        searchSongOnKeyboard("Tarkan")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single"]/*[[".cells.staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]",".staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["NoyanC_HW4.DetailView"].buttons["favorite"].tap()
        let favoriteButton = app.tabBars["Tab Bar"].buttons["Favorites"]
        favoriteButton.tap()
    }
    
    func test_play_song_detail_view_controller() {
        toSearchTextField()
        searchSongOnKeyboard("Tarkan")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single"]/*[[".cells.staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]",".staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["play"].tap()
        sleep(10)
        app.buttons["stop.circle"].tap()
    }
    
    func test_play_video_detail_view_controller() {
        toSearchTextField()
        searchSongOnKeyboard("Ezhel Aya")
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Ezhel")/*[[".cells.containing(.button, identifier:\"play.square.fill\")",".cells.containing(.staticText, identifier:\"Ezhel\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["AYA"].tap()
        app.buttons["play.square.fill"].tap()
        sleep(13)
    }
}
