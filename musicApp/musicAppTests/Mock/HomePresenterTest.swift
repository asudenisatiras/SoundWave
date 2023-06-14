//
//  HomePresenterTest.swift
//  musicAppTests
//
//  Created by Asude Nisa Tıraş on 15.06.2023.
//

import XCTest
@testable import musicApp

final class HomePresenterTest: XCTestCase {

    var presenter : HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!
    
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
    func test_viewDidLoad_InvokesRequiredViewMoethods() {
        
        XCTAssertFalse(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 0)
       
        XCTAssertFalse(interactor.isInvokedFetchSearchSongs)
        XCTAssertEqual(interactor.invokedFetchSearchSongsCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 1)
       
      //  XCTAssertTrue(interactor.isInvokedFetchSearchSongs)
      //  XCTAssertEqual(interactor.invokedFetchSearchSongsCount, 1)
        
    }
    func test_fetchNewsOutput() {
        
        XCTAssertFalse(view.isInvokedHideLoading)
       // XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertFalse(view.isInvokedReloadData)
        
     //   presenter.fetchSongsOutput(.success(.response))
        
        XCTAssertTrue(view.isInvokedHideLoading)
      //  XCTAssertEqual(presenter.numberOfItems(), 39)
        XCTAssertTrue(view.isInvokedReloadData)
    }



}
