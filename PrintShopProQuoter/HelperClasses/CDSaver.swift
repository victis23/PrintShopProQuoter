//
//  CompanySaver.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/5/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import CoreData
import UIKit


class Saver {
	
	public static var context : NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	func set() {}
	
	//Save values to persistent container.
	open func save() {
		
		do {
			try Saver.context.save()
		}
			
		catch(let error){
			print(error.localizedDescription)
		}
	}
}

class CompanySaver : Saver {
	
	private var newCompany : Company
	
	init(company : Company){
		self.newCompany = company
	}
	
	override func set() {
		
		//Creates instance of coredata entity CoreCompany.
		let company = CoreCompany(context: Saver.context)
		
		/// Block assigns values to persistent container.
		company.name = newCompany.name
		company.id = newCompany.id
		company.companyAddress = CoreAddress(context: Saver.context)
		company.companyAddress?.street = newCompany.address?.street
		company.companyAddress?.city = newCompany.address?.city
		company.companyAddress?.state = newCompany.address?.state
		company.companyAddress?.country = newCompany.address?.country
		company.companyAddress?.zipcode = newCompany.address?.zipcode
		
		company.contactList = encodeContactList(list: newCompany.contact)
		
		save()
	}
	
	private func encodeContactList(list:[Contact]?)-> Data?{
		guard let list = list else {return nil}
		let encoder = JSONEncoder()
		let data = try? encoder.encode(list)
		return data
		
//		var dataArray : Data?
//
//		do {
//			let rawDataArray : Data = try NSKeyedArchiver.archivedData(withRootObject: newCompany.contact ?? [], requiringSecureCoding: true)
//			dataArray = rawDataArray
//		}
//		catch(let e){
//			print(e.localizedDescription)
//		}
//
//		return dataArray ?? Data()
	}
}


