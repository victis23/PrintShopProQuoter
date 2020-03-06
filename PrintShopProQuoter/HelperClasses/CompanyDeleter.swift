//
//  CompanyDeleter.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/4/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import UIKit
import CoreData

/// Handles removing items from core data using item identifiers.
class CompanyDeleter {
	
	private let itemIdentifier : String
	private let context : NSManagedObjectContext = CompanySaver.context
	
	init?(identifier: String){
		self.itemIdentifier = identifier
	}
	
	/// Removes returned item from persistant data storage.
	public func removeObject() throws {
		guard let coreDataObject = getCoreDataObject() else {throw CoreDataDeleterError.valueNotFound}
		
		context.delete(coreDataObject)
		
		try context.save()
	}
	
	/// Creates fetch request and returns first object in return set that matches search identifier.
	private func getCoreDataObject()-> NSManagedObject?{
		
		let data = CompanyFetcher(keypath: \CoreCompany.name)
		let query : NSPredicate? = NSPredicate(format: "id = %@", itemIdentifier)
		let object = data.fetchFromCoreData(predicate: query)?.first

		return object
	}
}

