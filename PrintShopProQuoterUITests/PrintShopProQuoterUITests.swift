//
//  PrintShopProQuoterUITests.swift
//  PrintShopProQuoterUITests
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import XCTest

class PrintShopProQuoterUITests: XCTestCase {
	
	var app : XCUIApplication!
	var uiTestHelper : UITestingSupportClass!

    override func setUpWithError() throws {
		
		app = XCUIApplication()
		uiTestHelper = UITestingSupportClass(withQueryElement: app.tables)
		
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
		app = nil
		uiTestHelper = nil
    }

	/// Checks that submit button becomes active once all fields are filled on the form presented by the AddCustomer view.
    func testAddAddressButtonActivation() throws {
        
		app.launch()
		app.navigationBars["Customer List"].buttons["Add Customer"].tap()
		
		//Sets Company Name in Company Name Field.
		uiTestHelper.setupCompanyName()
		
		//Transition to Address Input Screen.
		uiTestHelper.setupAddress()
		
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
	
	func testRemoveListMemeber() throws {
		
		app.launch()
		
	}
}


class UITestingSupportClass {
	
	private var tablesQuery : XCUIElementQuery
	
	init(withQueryElement tablesQuery: XCUIElementQuery){
		self.tablesQuery = tablesQuery
	}
	
	func getTableQuery()-> XCUIElementQuery {
		return tablesQuery
	}
	
	func setupCompanyName(){
		
		let companyField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Company Name"]/*[[".cells.textFields[\"Company Name\"]",".textFields[\"Company Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		companyField.tap()
		companyField.typeText("TestCompany")
	}
	
	func setupAddress() {
		
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
	}
	
}
