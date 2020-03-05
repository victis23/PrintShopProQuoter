//
//  CompanyDeleter.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/4/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import UIKit
import CoreData

class CompanyDeleter {
	
	private let itemIdentifier : String
	private let context : NSManagedObjectContext
	
	init?(identifier: String, context : NSManagedObjectContext){
		self.itemIdentifier = identifier
		self.context = context
	}
	
	private func getCoreDataObject()-> NSManagedObject?{
		
		let data = CompanyFetcher()
		
		let object = data.fetchFromCoreData()?.first(where: { item -> Bool in
			item.id == itemIdentifier
		})
		
		return object
	}
	
	public func removeObject() throws {
		guard let coreDataObject = getCoreDataObject() else {throw CoreDataDeleterError.valueNotFound}
		
		context.delete(coreDataObject)
		
		try context.save()
	}
}

