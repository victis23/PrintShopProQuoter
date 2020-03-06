//
//  CompanySaver.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/5/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import CoreData


class CompanySaver  {
	
	private var newCompany : Company
	private var context : NSManagedObjectContext
	
	init(company : Company, context : NSManagedObjectContext){
		self.newCompany = company
		self.context = context
	}
	
	func set() {
		
		//Creates instance of coredata entity CoreCompany.
		let company = CoreCompany(context: context)
		
		/// Block assigns values to persistent container.
		company.name = newCompany.name
		company.id = newCompany.id
		company.companyAddress = CoreAddress(context: self.context)
		company.companyAddress?.street = newCompany.address?.street
		company.companyAddress?.city = newCompany.address?.city
		company.companyAddress?.state = newCompany.address?.state
		company.companyAddress?.country = newCompany.address?.country
		company.companyAddress?.zipcode = newCompany.address?.zipcode
		
		save()
	}
	
	//Save values to persistent container.
	private func save() {
		
		do {
			try context.save()
		}
			
		catch(let error){
			print(error.localizedDescription)
		}
	}
}
