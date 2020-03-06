//
//  File.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import UIKit
import CoreData

protocol setKeyPath {
	associatedtype Root
	associatedtype Value
	associatedtype ManagedObject
	var keypath : KeyPath<Root,Value> {get set}
}

/// FetchCompanies retrieves data from persistent container and returns an array of CoreCompany objects.
class CompanyFetcher {
	
	private var context : NSManagedObjectContext {
		let context = CompanySaver.context
		return context
	}
	
	private let request : NSFetchRequest<CoreCompany> = NSFetchRequest(entityName: "CoreCompany")
	
	/// Returns list of CoreCompany objects that will be used to initialize `MainVC`
	func fetchFromCoreData(predicate : NSPredicate? = nil) -> [CoreCompany]? {
		request.sortDescriptors = [NSSortDescriptor(keyPath: \CoreCompany.name, ascending: true)]
		request.predicate = predicate
		let response = try? context.fetch(request)
		return response
	}
}
