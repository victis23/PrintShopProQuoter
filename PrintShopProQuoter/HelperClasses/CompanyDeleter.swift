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
	
	private let index : String
	private let context : NSManagedObjectContext
	
	init?(index: String, context : NSManagedObjectContext){
		self.index = index
		self.context = context
	}
	
	private func getCoreDataObject()-> NSManagedObject?{
		
		let data = CompanyFetcher()
		
		let object = data.fetchFromCoreData()?.first(where: { item -> Bool in
			item.id == index
		})
		
		return object
	}
	
	public func removeObject() throws {
		guard let coreDataObject = getCoreDataObject() else {throw CoreDataDeleterError.valueNotFound}
		
		context.delete(coreDataObject)
		
		try context.save()
	}
}

