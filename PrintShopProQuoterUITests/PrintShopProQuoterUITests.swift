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
		uiTestHelper = UITestingSupportClass(withQueryElement: app.tables, on: app)
		
		continueAfterFailure = false
		
		//This value is checked in application delegate.
//		app.launchArguments.append("--uitesting")
	}
	
	override func tearDownWithError() throws {
		app = nil
		uiTestHelper = nil
	}
	
	
	func testAddCompanyName() throws {
		app.launch()
		app.navigationBars["Customer List"].buttons["Add Customer"].tap()
		uiTestHelper.setupCompanyName()
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
	
	/// For user to submit a contact email address must be valid. This test checks that validation is functioning properly when email address is valid.
	func testAddContactWithValidEmail() throws {
		
		app.launch()
		app.navigationBars["Customer List"].buttons["Add Customer"].tap()
		
		uiTestHelper.setupContactWithValidEmail()
		
		let submitButton = app.buttons["pencil.and.ellipsis.rectangle"]
		XCTAssertTrue(submitButton.isEnabled)
	}
	
	/// For user to submit a contact email address must be valid. This test checks that validation is functioning properly when email address is invalid.
	func testAddContactWithINVALIDEmail() throws {
		
		app.launch()
		app.navigationBars["Customer List"].buttons["Add Customer"].tap()
		
		uiTestHelper.setupContactWithINVALIDEmail()
		
		let submitButton = app.buttons["pencil.and.ellipsis.rectangle"]
		XCTAssertFalse(submitButton.isEnabled)
	}
	
	/// Verify that after a contact is added to the contact list tableview the submit button becomes active.
	func testSubmitContactlist() throws {
		
		app.launch()
		app.navigationBars["Customer List"].buttons["Add Customer"].tap()
		
		uiTestHelper.setupContactWithValidEmail()
		
		let addContact = app.buttons["pencil.and.ellipsis.rectangle"]
		
		addContact.tap()
		
		let submitContact = app.buttons["tray.and.arrow.down.fill"]
		
		XCTAssertTrue(submitContact.isEnabled)
	}
	
	/// Verify that user CRM is working by combining all of the tasks until user returns to main screen.
	
	func testCRM() throws {
		
		app.launch()
		app.navigationBars["Customer List"].buttons["Add Customer"].tap()
		uiTestHelper.setupCompanyName()
		uiTestHelper.setupAddress()
		app.buttons["tray.and.arrow.down.fill"].tap()
		uiTestHelper.setupContactWithValidEmail()
		app.buttons["pencil.and.ellipsis.rectangle"].tap()
		app.buttons["tray.and.arrow.down.fill"].tap()
		app.buttons["tray.and.arrow.down.fill"].tap()
		
		print(app.navigationBars["Customer List"].otherElements.containing(.button, identifier: "Add Customer").element.exists)
		
	}
}


