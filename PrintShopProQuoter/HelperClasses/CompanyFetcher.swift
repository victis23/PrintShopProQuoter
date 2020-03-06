//
//  File.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import UIKit
import CoreData

/// FetchCompanies retrieves data from persistent container and returns an array of CoreCompany objects.
class CoreDataFetcher<R,V,ReturnValue> : CoreDataFetcherProtocol where ReturnValue : NSFetchRequestResult {
	
	typealias Root = R
	typealias Value = V
	typealias ManagedObject = ReturnValue
	
	internal var keypath: KeyPath<R, V>
	internal var request : NSFetchRequest<ReturnValue> 
	
	init(sortBy keypath : KeyPath<R,V>, request : NSFetchRequest<ReturnValue>){
		self.keypath = keypath
		self.request = request
	}
	
	private var context : NSManagedObjectContext {
		let context = CompanySaver.context
		return context
	}
	
	
	/// Returns list of CoreCompany objects that will be used to initialize `MainVC`
	func fetchFromCoreData(predicate : NSPredicate? = nil) -> [ReturnValue]? {
		
		request.sortDescriptors = [NSSortDescriptor(keyPath: keypath, ascending: true)]
		request.predicate = predicate
		
		let response = try? context.fetch(request)
		
		return response
	}
}
