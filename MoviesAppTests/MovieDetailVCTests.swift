//
//  MovieDetailVCTests.swift
//  MoviesAppTests
//
//  Created by Arpit Jain on 16/05/21.
//

import XCTest
@testable import MoviesApp

class MovieDetailVCTests: XCTestCase {

    /// System under test
    var objController: MoviesDetailVC?
    
    override func setUp() {
        objController = initializeFromStoryboard()
        objController?.loadView()
        objController?.registerNib()
    }

    func initializeFromStoryboard() -> MoviesDetailVC? {
        let storyboard = UIStoryboard(name: "Movie",  bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesDetailVC" ) as? MoviesDetailVC
        return controller
    }
    
    func testViewDidLoad() {
        objController?.viewDidLoad()
    }
    
    func testShowSimilarMovies() {
        objController?.showHideSimilarMovies(true)
        XCTAssertTrue(objController?.lblSimilarMoviesTitle.isHidden ?? false)
    }
    
    func testHideSimilarMovies() {
        objController?.showHideSimilarMovies(false)
        XCTAssertFalse(objController?.lblSimilarMoviesTitle.isHidden ?? false)
    }
    
    func testCreditsCellForRow() {
        let objCell = objController?.collectionView(objController?.cvCredits ?? UICollectionView(), cellForItemAt: IndexPath.init(row: 1, section: 0))
        XCTAssertNotNil(objCell, "UICollectionView should be able to load row in cell")
        
    }
    
    func testMoviesCellForRow() {
        let objCell = objController?.collectionView(objController?.cvSimilarMovies ?? UICollectionView(), cellForItemAt: IndexPath(row: 1, section: 0))
        XCTAssertNotNil(objCell, "UICollectionView should be able to load row in cell")
    }
    
    func testCreditsDidSelectRow() {
        XCTAssertNotNil(objController?.collectionView(objController?.cvCredits ?? UICollectionView(), didSelectItemAt: IndexPath(row: 1, section: 0)))
        
    }
    
    func testMoviesDidSelectRow() {
        XCTAssertNotNil(objController?.collectionView(objController?.cvSimilarMovies ?? UICollectionView(), didSelectItemAt: IndexPath(row: 1, section: 0)))
    }
    
}
