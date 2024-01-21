//
//  VippsTestUITests.swift
//  VippsTestUITests
//
//  Created by SK on 21/01/24.
//

import XCTest

class VippsTestUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testHomeScreen() throws {
        
        // SearchTextField
        let textField = app.textFields["searchTextField"]
        XCTAssertTrue(textField.exists)
        
        textField.tap()
        textField.typeText("Tennis")

        // Search Button
        let button = app.buttons["searchButton"]
        XCTAssertTrue(button.exists)

        button.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
