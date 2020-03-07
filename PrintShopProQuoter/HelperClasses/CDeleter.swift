//
//  Deleter.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/4/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import UIKit
import CoreData

/// Handles removing items from core data using item identifiers.
class Deleter<Object: NSFetchRequestResult, R, V> : CoreDataFetcherProtocol {
	
	typealias Root = R
	
	typealias Value = V
	
	typealias ManagedObject = Object
	
	var keypath: KeyPath<R, V>
	var request: NSFetchRequest<Object>
	var nsPredicateFormat : String
	
	
	private let itemIdentifier : String
	private let context : NSManagedObjectContext = Saver.context
	
	init?(identifier: String, keypath: KeyPath<R,V>, CDType type : NSFetchRequest<Object>, filter nsPredicateFormat : String){
		self.itemIdentifier = identifier
		self.keypath = keypath
		self.request = type
		self.nsPredicateFormat = nsPredicateFormat
	}
	
	/// Removes returned item from persistant data storage.
	public func removeObject() throws {
		guard let coreDataObject = getCoreDataObject() else {throw CoreDataDeleterError.valueNotFound}
		
		context.delete(coreDataObject)
		
		try context.save()
	}
	
	/// Creates fetch request and returns first object in return set that matches search identifier.
	private func getCoreDataObject()-> NSManagedObject?{
		
		let data = Fetcher(sortBy: keypath, request: request)
		let query : NSPredicate? = NSPredicate(format: nsPredicateFormat, itemIdentifier)
		let object = data.fetchFromCoreData(predicate: query)?.first as! NSManagedObject

		return object
	}
}

