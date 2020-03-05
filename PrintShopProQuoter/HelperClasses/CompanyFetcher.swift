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
class CompanyFetcher {
	
	private var context : NSManagedObjectContext {
		let context = (UIApplication.shared.delegate as! AppDelegate)
			.persistentContainer.viewContext
		return context
	}
	
	private let request : NSFetchRequest<CoreCompany> = NSFetchRequest(entityName: "CoreCompany")
	
	/// Returns list of CoreCompany objects that will be used to initialize `MainVC`
	func fetchFromCoreData() -> [CoreCompany]? {
		request.sortDescriptors = [NSSortDescriptor(keyPath: \CoreCompany.name, ascending: true)]
		let response = try? context.fetch(request)
		return response
	}
}
