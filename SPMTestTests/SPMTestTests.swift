// Created on 11/07/2022

@testable import SPMTest
import XCTest

class SPMTestTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_FilmDetailViewModel_isNill() {
        // given
        let film = testData()
        
        //when
        let vm = FilmDetailViewModel(film: film)
        
        //then
        XCTAssertTrue((vm.film != nil))
        
    }
    
    func test_FilmDetailViewModel_isNotNill() {
        // given
        let filmNil: Film? = nil
        
        //when
        let film = testData()
        
        //then
        XCTAssertNotNil(filmNil ?? film)
    }
    
    func test_SearchMovies_isNotEqual() {
        //given
        let dependencyContainer = DependencyContainer()
        let navigationController = SWAPINavigationController()
        let coordinator = FilmCordinatorImpl(navigationController: navigationController)
        let searchText = "Tes"
        let array: [Film] = [testData()]
        
        let vm = FilmListViewModel(userRepository: dependencyContainer.userRepository,
                                   coordinator: coordinator)
        //when
        let filteredValue = vm.filterMovies(films: array, searchText: searchText)
        XCTAssertTrue(!filteredValue.isEmpty)
    }
    
    func test_SearchMovies_isNotEmpty() {
        //given
        let dependencyContainer = DependencyContainer()
        let navigationController = SWAPINavigationController()
        let coordinator = FilmCordinatorImpl(navigationController: navigationController)
        let searchText = "Test"
        let array: [Film] = [testData()]
        
        //when
        let vm = FilmListViewModel(userRepository: dependencyContainer.userRepository,
                                   coordinator: coordinator)
        let filteredValue = vm.filterMovies(films: array, searchText: searchText)
        
        //then
        XCTAssertEqual(searchText, filteredValue.first?.title)
    }
    
    func test_SearchText_isEmpty() {
        //given
        let dependencyContainer = DependencyContainer()
        let navigationController = SWAPINavigationController()
        let coordinator = FilmCordinatorImpl(navigationController: navigationController)
        let searchText = ""
        let array: [Film] = [testData()]
        
        //when
        let vm = FilmListViewModel(userRepository: dependencyContainer.userRepository,
                                   coordinator: coordinator)
        let filteredValue = vm.filterMovies(films: array, searchText: searchText)
        
        //then
        XCTAssertEqual(0, filteredValue.count)
    }
    
    func test_searchResults_isEmpty() {
        //given
        let dependencyContainer = DependencyContainer()
        let navigationController = SWAPINavigationController()
        let coordinator = FilmCordinatorImpl(navigationController: navigationController)
        let searchText = ""
        let array: [Film] = [testData()]
        
        //when
        let vm = FilmListViewModel(userRepository: dependencyContainer.userRepository,
                                   coordinator: coordinator)
        let filteredValue = vm.searchResults(allFilms: array, searchText: searchText)
        
        //then
        XCTAssertTrue(filteredValue.count > 0)
    }
    
    func test_searchResults_isNotEmpty() {
        //given
        let dependencyContainer = DependencyContainer()
        let navigationController = SWAPINavigationController()
        let coordinator = FilmCordinatorImpl(navigationController: navigationController)
        let searchText = "Test"
        let array: [Film] = [testData()]
        
        //when
        let vm = FilmListViewModel(userRepository: dependencyContainer.userRepository,
                                   coordinator: coordinator)
        let filteredValue = vm.searchResults(allFilms: array, searchText: searchText)
        
        //then
        XCTAssertTrue(filteredValue.count > 0)
    }
    
    func test_showDetail_isEmpty() {
        //given
        let dependencyContainer = DependencyContainer()
        let navigationController = SWAPINavigationController()
        let coordinator = FilmCordinatorImpl(navigationController: navigationController)
        let array = testData()
        
        //when
        let vm = FilmListViewModel(userRepository: dependencyContainer.userRepository,
                                   coordinator: coordinator)
        let filteredValue = vm.showDeils(film: array)
        
        //then
        XCTAssertNotNil(filteredValue)
    }
}


extension SPMTestTests {
    func testData() -> Film {
        let film = Film(title: "Test",
                        episodeId: 2,
                        openingCrawl: "It is  to the galaxy....",
                        director: "George Lucas",
                        producer: "Gary Kurtz, Rick McCallum",
                        releaseDate: "1977-05-25",
                        created: "2014-12-10T14:23:31.880000Z",
                        edited: "2014-12-20T19:49:45.256000Z",
                        url: "https://swapi.dev/api/films/1/")
        return film
    }
}

/*
  "count": 6,
  "next": null,
  "previous": null,
  "results": [
  {
     "title": "A New Hope",
     "episode_id": 4,
     "opening_crawl": "It is  to the galaxy....",
     "director": "George Lucas",
     "producer": "Gary Kurtz, Rick McCallum",
     "release_date": "1977-05-25",
     "characters": [],
     "planets": [],
     "starships": [],
     "vehicles": [],
     "species": [],
     "created": "2014-12-10T14:23:31.880000Z",
     "edited": "2014-12-20T19:49:45.256000Z",
     "url": "https://swapi.dev/api/films/1/"
 }]
 */
