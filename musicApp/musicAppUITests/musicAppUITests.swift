//
//  musicAppUITests.swift
//  musicAppUITests
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

//import XCTest
//
//final class musicAppUITests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
//}
import XCTest

final class iTunesMusicUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    func testExampleController() {
        
        
        
        
        let app = XCUIApplication()
        app.launch()
       
        let search =  app.searchFields["searchBar"]
        search.tap()
        XCTAssertTrue(search.waitForExistence(timeout: 5))
        search.typeText("Tarkan")
        app.keyboards.buttons["Search"].tap()
       let tableCells = app.tables["tableView"].cells.element(boundBy: 1)
        tableCells.tap()
        app/*@START_MENU_TOKEN@*/.buttons["playButton"]/*[[".buttons[\"play\"]",".buttons[\"playButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(3)
        app/*@START_MENU_TOKEN@*/.buttons["playButton"]/*[[".buttons[\"pause\"]",".buttons[\"playButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let likedbuttonButton = app/*@START_MENU_TOKEN@*/.buttons["likedButton"]/*[[".buttons[\"love\"]",".buttons[\"likedButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        likedbuttonButton.tap()
        
              
        
      
         

        

    }

}
