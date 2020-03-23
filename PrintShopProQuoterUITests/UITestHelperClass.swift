//
//  UITestHelperClass.swift
//  PrintShopProQuoterUITests
//
//  Created by Scott Leonard on 3/22/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import XCTest

class UITestingSupportClass {
	
	private var tablesQuery : XCUIElementQuery
	private var app : XCUIApplication
	
	init(withQueryElement tablesQuery: XCUIElementQuery, on app: XCUIApplication){
		self.tablesQuery = tablesQuery
		self.app = app
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
		zipcodeField.typeText("test zipcode \n")
	}
	
	func setupContactWithValidEmail(){
		
		tablesQuery/*@START_MENU_TOKEN@*/.buttons["Contact Info"]/*[[".cells.buttons[\"Contact Info\"]",".buttons[\"Contact Info\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		let nameTextField = tablesQuery.textFields["Name"]
		let phoneTextField = tablesQuery.textFields["Phone Number"]
		let emailTextField = tablesQuery.textFields["Email"]
		
		nameTextField.tap()
		nameTextField.typeText("Test Customer")
		
		phoneTextField.tap()
		phoneTextField.typeText("Test PhoneNumber")
		
		emailTextField.tap()
		emailTextField.typeText("test@test.com \n")
	}
	
	func setupContactWithINVALIDEmail(){
		
		tablesQuery/*@START_MENU_TOKEN@*/.buttons["Contact Info"]/*[[".cells.buttons[\"Contact Info\"]",".buttons[\"Contact Info\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		let nameTextField = tablesQuery.textFields["Name"]
		let phoneTextField = tablesQuery.textFields["Phone Number"]
		let emailTextField = tablesQuery.textFields["Email"]
		
		nameTextField.tap()
		nameTextField.typeText("Test Customer")
		
		phoneTextField.tap()
		phoneTextField.typeText("Test PhoneNumber")
		
		emailTextField.tap()
		emailTextField.typeText("wrong email")
	}
	
}

