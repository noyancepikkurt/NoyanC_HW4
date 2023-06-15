
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
    
    private func searchTarkanSongOnKeyboard() {
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        let kKey = app/*@START_MENU_TOKEN@*/.keys["k"]/*[[".keyboards.keys[\"k\"]",".keys[\"k\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        kKey.tap()
        aKey.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
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
        searchTarkanSongOnKeyboard()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single"]/*[[".cells.staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]",".staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["NoyanC_HW4.DetailView"].buttons["Back"].tap()
    }
    
    func test_add_favorite_song_from_detail_view_controller() throws {
        toSearchTextField()
        searchTarkanSongOnKeyboard()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single"]/*[[".cells.staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]",".staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["NoyanC_HW4.DetailView"].buttons["favorite"].tap()
        let favoriteButton = app.tabBars["Tab Bar"].buttons["Favorites"]
        favoriteButton.tap()
    }
    
    func test_play_song_detail_view_controller() {
        toSearchTextField()
        searchTarkanSongOnKeyboard()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single"]/*[[".cells.staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]",".staticTexts[\"Hop De - Zamansız Şarkılar, Vol. 2 (feat. Tarkan) - Single\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["play"].tap()
        sleep(7)
        app.buttons["stop.circle"].tap()
    }
    
    func test_play_video_detail_view_controller() {
        toSearchTextField()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let zKey = app/*@START_MENU_TOKEN@*/.keys["z"]/*[[".keyboards.keys[\"z\"]",".keys[\"z\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        zKey.tap()
        
        let hKey = app/*@START_MENU_TOKEN@*/.keys["h"]/*[[".keyboards.keys[\"h\"]",".keys[\"h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hKey.tap()
        eKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        
        let boLukKey = app/*@START_MENU_TOKEN@*/.keys["Boşluk"]/*[[".keyboards.keys[\"Boşluk\"]",".keys[\"Boşluk\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        boLukKey.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let yKey = app/*@START_MENU_TOKEN@*/.keys["y"]/*[[".keyboards.keys[\"y\"]",".keys[\"y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        yKey.tap()
        aKey.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Ezhel")/*[[".cells.containing(.button, identifier:\"play.square.fill\")",".cells.containing(.staticText, identifier:\"Ezhel\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["AYA"].tap()
        app.buttons["play.square.fill"].tap()
        sleep(10)
    }
}
