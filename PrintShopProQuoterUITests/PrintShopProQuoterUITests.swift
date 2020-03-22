//
//  PrintShopProQuoterUITests.swift
//  PrintShopProQuoterUITests
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import XCTest

class PrintShopProQuoterUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddAddressButtonActivation() throws {
        
		let app = XCUIApplication()
		app.launch()
		app.navigationBars["Customer List"].buttons["Add Customer"].tap()
		
		let tablesQuery = app.tables
		
		let companyField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Company Name"]/*[[".cells.textFields[\"Company Name\"]",".textFields[\"Company Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		companyField.tap()
		companyField.typeText("TestCompany")
		
		//Transition to Address Input Screen.
		
		tablesQuery/*@START_MENU_TOKEN@*/.buttons["Address\n ,  "]/*[[".cells.buttons[\"Address\\n ,  \"]",".buttons[\"Address\\n ,  \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		let streetField = tablesQuery.textFields["Street"]
		let cityField = tablesQuery.textFields["City"]
		let stateField = tablesQuery.textFields["State"]
		let countryField = tablesQuery.textFields["Country"]
		let zipcodeField = tablesQuery.textFields["Zipcode"]
		
		streetField.tap()
		streetField.typeText("test street")
		
		cityField.tap()
		cityField.typeText("test city")
		
		stateField.tap()
		stateField.typeText("test state")
		
		countryField.tap()
		countryField.typeText("test country")
		
		zipcodeField.tap()
		zipcodeField.typeText("test zipcode")
		
		let trayAndArrowDownFillButton = app.buttons["tray.and.arrow.down.fill"]
		
		XCTAssertTrue(trayAndArrowDownFillButton.isEnabled)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
