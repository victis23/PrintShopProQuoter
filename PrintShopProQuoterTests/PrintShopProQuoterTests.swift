//
//  PrintShopProQuoterTests.swift
//  PrintShopProQuoterTests
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import XCTest
import CoreData
@testable import PrintShopProQuoter

class PrintShopProQuoterTests: XCTestCase {
	
	var fetcher : Fetcher<CoreCompany, String?, CoreCompany>!
	var saver : CompanySaver!
	var defaultCompany : Company!

    override func setUpWithError() throws {
		
		defaultCompany = Company(name: "TestValue", address: nil, contact: [Contact(name: "Michael", phone: "407-310-7310", email: "test@test.com", id: "tester")], quotes: nil, orders: nil, id: "test")
		
		fetcher = Fetcher(sortBy: \CoreCompany.name, request: NSFetchRequest<CoreCompany>(entityName: CORE_COMPANY))
		
		saver = CompanySaver(company: defaultCompany)
    }

    override func tearDownWithError() throws {
		
        fetcher = nil
		saver = nil
		defaultCompany = nil
    }

	/// Tests whether or not fetch method is returning values from persistant container. If method should return Array<CoreCompany?>, but could technically be used to return an array of any NSManaged Object. 
	func testFetcherClass(){
		XCTAssertNotNil(fetcher.fetchFromCoreData())
	}
	
	/// Verifies that context is being created from static property on Saver class.
	func testContext() {
		XCTAssertNotNil(Saver.context)
	}
	
	/// Checks to see if default company is being saved to core data persistent container.
	func testSaverClass(){
		
		defer {
			// Erase test value from Coredata as part of our cleanup.
			if !(savedCompany?.isEmpty ?? false)  {
				deleter(id: id)
			}
		}
		
		saver.set()
		
		let id = defaultCompany.id
		
		let _localFetcher = Fetcher<CoreCompany, String?, CoreCompany>(sortBy: \CoreCompany.id, request: NSFetchRequest(entityName: CORE_COMPANY))
		
		let savedCompany = _localFetcher.fetchFromCoreData(predicate: NSPredicate(format: "id = %@", id))
		XCTAssertTrue(savedCompany?[0].id == id)
	}
	
	/// Checks to make sure deleter class successfully removes item from persistent container. 
	func testDeleter(){
		
		saver.set()
		let deleter = Deleter<NSFetchRequestResult, CoreCompany, String?>(identifier: defaultCompany.id, keypath: \CoreCompany.name, CDType: NSFetchRequest(entityName: CORE_COMPANY), filter: "id = %@")
		XCTAssertNoThrow(try deleter?.removeObject())
		
	}
	
	/// Removes item with specified id from persistent container.
	func deleter(id:String){
		let deleter = Deleter<NSFetchRequestResult, CoreCompany, String?>(identifier: id, keypath: \CoreCompany.name, CDType: NSFetchRequest(entityName: CORE_COMPANY), filter: "id = %@")
		try? deleter?.removeObject()
	}
	
	/// Tests whether persistant container is holding the correct value once Saver Class calls `set()` method.
	/// - Note: This is not a mock test, object needs to be removed from persistent container once test is finished.
	func testSaverClassFail(){
		
		defer {
			deleter(id: defaultCompany.id)
		}
		
		saver.set()
		
		let id = "AnotherValue"
		
		let _localFetcher = Fetcher<CoreCompany, String?, CoreCompany>(sortBy: \CoreCompany.id, request: NSFetchRequest(entityName: CORE_COMPANY))
		
		let savedCompany = _localFetcher.fetchFromCoreData(predicate: NSPredicate(format: "id = %@", id))
		XCTAssertEqual(savedCompany, [])
	}
	
	/// Verifies that contact retriever is retriving list of contacts from persistent container.
	func testContactRetriever(){
		
		defer {
			deleter(id: defaultCompany.id)
		}
		
		saver.set()
		
		let _localFetcher = Fetcher<CoreCompany, String?, CoreCompany>(sortBy: \CoreCompany.id, request: NSFetchRequest(entityName: CORE_COMPANY))
		
		let savedCompany = _localFetcher.fetchFromCoreData(predicate: NSPredicate(format: "id = %@", defaultCompany.id))
		
		let firstItem = (savedCompany?.first)!
		
		let contractRetriver = ContactListFetcher(managedObject: firstItem)
		let contacts = contractRetriver.getContactList()
		
		XCTAssertTrue(contacts.contains(where: { contact in contact.name == "Michael"}))
	}
}
