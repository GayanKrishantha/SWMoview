// Created on 11/07/2022

import XCTest

class SPMTestUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()
    }

    func test_filmListView_listLoader_exist() throws {
        let listLoader = self.app.otherElements["listLoader"]
        XCTAssert(listLoader.exists)
    }
    
    func test_filmListView_listItem_exist() throws {
        let movieListSearch = self.app.scrollViews.otherElements.containing(.staticText, identifier:"listItem").element
        XCTAssert(movieListSearch.exists)
    }
    
    func test_filmListView_searchBar_exist() throws {
        let movies = self.app.navigationBars["Movies"]
        XCTAssert(movies.exists)
    }
    
    func test_filmListView_searchBarCancelButton_exist() throws {
        let searchBar = self.app.navigationBars["Movies"].searchFields["Search"]
        XCTAssert(searchBar.exists)
    }
    
    func test_filmListView_searchBar_exist2() throws {
        let searchBar = self.app.scrollViews.otherElements.containing(.staticText, identifier:"movieListSearch").element
        XCTAssert(searchBar.exists)
    }
}
