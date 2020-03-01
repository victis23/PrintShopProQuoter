//
//  MainController.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

class MainVC : UIHostingController<Main> {
	
	static func fetchCompanies() -> [CoreCompany]? {
		
		let context = (UIApplication.shared.delegate as! AppDelegate)
			.persistentContainer.viewContext
		
		let request : NSFetchRequest<CoreCompany> = NSFetchRequest(entityName: "CoreCompany")
		request.sortDescriptors = [NSSortDescriptor(keyPath: \CoreCompany.name, ascending: true)]
		
		let response = try? context.fetch(request)
		
		return response
	}
	
	override init?(coder aDecoder: NSCoder, rootView: Main) {
		super.init(coder: aDecoder, rootView: rootView)
	}
	
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder, rootView: Main(displayText: "This is only a test!", retrievedList: MainVC.fetchCompanies()))
	}
}
