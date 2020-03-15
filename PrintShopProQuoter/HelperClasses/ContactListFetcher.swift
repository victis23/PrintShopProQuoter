//
//  ContactListFetcher.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/15/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import Foundation
import CoreData

class ContactListFetcher {
	
	private var managedObject:NSManagedObject
	
	init(managedObject:NSManagedObject){
		self.managedObject = managedObject
	}
	
	func GetContactList()-> [Contact]{
		let company = managedObject as! CoreCompany
		let decoder = JSONDecoder()
		let value = try? decoder.decode([Contact].self, from: company.contactList ?? Data())
		return value ?? []
	}
}
