//
//  MoviesListVCTests.swift
//  MoviesAppTests
//
//  Created by Arpit Jain on 16/05/21.
//

import XCTest
@testable import MoviesApp

class MoviesListVCTests: XCTestCase {
    
    var objController: MoviesListVC?
    
    override func setUp() {
        objController = initializeFromStoryboard()
        objController?.loadView()
    }
    
    func initializeFromStoryboard() -> MoviesListVC? {
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesListVC" ) as? MoviesListVC
        return controller
    }
    
    func testViewDidLoad() {
        objController?.viewDidLoad()
    }
    
    func testViewWillAppear() {
        objController?.viewWillAppear(true)
    }
    
    func testRefreshMoviesList() {
        if let searchBar = objController?.objSearchBar {
            objController?.searchBar(searchBar, textDidChange: "KO")
            objController?.searchBarTextDidBeginEditing(searchBar)
            objController?.searchBarTextDidEndEditing(searchBar)
            objController?.searchBarSearchButtonClicked(searchBar)
            XCTAssertNotNil(objController?.objSearchBar)
        }
    }
    
    func testBtnCancelTapped() {
        if let button = objController?.btnCancel {
            objController?.btnCancelTapped(button)
        }
        XCTAssertEqual(objController?.isSearchActive, false)
    }
    
    func testManageRecentSearch() {
        objController?.manageRecentSearch()
        XCTAssertNotNil(objController?.tblViewList)
    }
    
    func testGetGenresFromIds() {
        let testString =  objController?.getGenresFromIds(prepareDummydata())
        XCTAssertTrue((testString?.isEmpty ?? false))
    }
    
    func testMovieCellForRow() {
        let objCell = objController?.tableView(objController?.tblViewList ?? UITableView(), cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertNotNil(objCell, "TableView should be able to load row in cell")
    }
    
    func testScrollView() {
        objController?.scrollViewDidScroll(objController?.tblViewList ?? UIScrollView())
    }
    
    func prepareDummydata() -> Movie {
        return Movie(adult: false,
                     backdropPath: "/6ELCZlTA5lGUops70hKdB83WJxH.jpg",
                     genreIDS: [28,14,12],
                     id: 460465,
                     originalLanguage: "en",
                     originalTitle: "Mortal Kombat",
                     overview: "Washed-up MMA fighter Cole Young, unaware of his heritage, and hunted by Emperor Shang Tsung\'s best warrior, Sub-Zero, seeks out and trains with Earth\'s greatest champions as he prepares to stand against the enemies of Outworld in a high stakes battle for the universe.",
                     popularity: 3345.294,
                     posterPath: "/xGuOF1T3WmPsAcQEQJfnG7Ud9f8.jpg",
                     releaseDate: "2021-04-07",
                     title: "Mortal Kombat",
                     video: false,
                     voteAverage: 7.7,
                     voteCount: 2429)
    }
}
