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

    override func setUpWithError() throws {
		fetcher = Fetcher(sortBy: \CoreCompany.name, request: NSFetchRequest<CoreCompany>(entityName: CORE_COMPANY))
    }

    override func tearDownWithError() throws {
        fetcher = nil
    }

	/// Tests whether or not fetch method is returning values from persistant container. If method should return Array<CoreCompany?>, but could technically be used to return an array of any NSManaged Object. 
	func testFetcherClass(){
		XCTAssertNotNil(fetcher.fetchFromCoreData())
	}

}
