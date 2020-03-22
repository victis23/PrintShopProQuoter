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
		
		defaultCompany = Company(name: "TestValue", address: nil, contact: nil, quotes: nil, orders: nil, id: "test")
		
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
	
	func testContext() {
		XCTAssertNotNil(Saver.context)
	}
	
	func testSaverClass(){
		
		defer {
			// Erase test value from Coredata as part of our cleanup.
			if !(savedCompany?.isEmpty ?? false)  {
				deleter(id: id)
			}
		}
		
		saver.set()
		
		let id = "test"
		
		let _localFetcher = Fetcher<CoreCompany, String?, CoreCompany>(sortBy: \CoreCompany.id, request: NSFetchRequest(entityName: CORE_COMPANY))
		
		let savedCompany = _localFetcher.fetchFromCoreData(predicate: NSPredicate(format: "id = %@", id))
		XCTAssertTrue(savedCompany?[0].id == id)
	}
	
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
}
