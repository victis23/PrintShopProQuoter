//
//  ContactListFetcher.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/15/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import Foundation
import CoreData

///Retrieves contact list from `Core Data` persistent storage.
class ContactListFetcher {
	
	private var managedObject:NSManagedObject
	
	init(managedObject:NSManagedObject){
		self.managedObject = managedObject
	}
	
	//FIXME: Eventually this method needs to be converted into a generic method for testing. Polymorphism ...
	/// Uses json decoder to decode retrieved Contact List data.
	func GetContactList()-> [Contact]{
		let company = managedObject as! CoreCompany
		let decoder = JSONDecoder()
		let value = try? decoder.decode([Contact].self, from: company.contactList ?? Data())
		return value ?? []
	}
}
