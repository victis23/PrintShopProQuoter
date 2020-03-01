//
//  ViewController.swift
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
		
		// Retrieves the persistent container for CoreData Entities from our AppDelegate.
		let context = (UIApplication.shared.delegate as! AppDelegate)
			.persistentContainer.viewContext
		
		/// In a pure SwiftUI project these would be instanciated inside the SceneDelegate however when being hosted we declare these during initalization.
		// Create an instance of Main and link coredata context to its managedObjectContext property.
		// Add instance of Customer class as an environmentObject
		let mainSwiftUI = Main()
		.environment(\.managedObjectContext, context)
			.environmentObject(Customers())
		
		super.init(coder: aDecoder, rootView: mainSwiftUI as! Main)
	}
}

struct Main : View {
	
	// Observed object that contains the current list of customers.
	@EnvironmentObject var customerList : Customers
	
	// Fetch request retrieves list of saved companies stored in coredata.
	@FetchRequest<CoreCompany>(entity: CoreCompany.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CoreCompany.name, ascending: true)]) var savedCompanies
	
	var body : some View {
		
		Text("Time to start work!")
	}
}


struct ViewController_Previews: PreviewProvider {
	static var previews: some View {
		Main()
	}
}
