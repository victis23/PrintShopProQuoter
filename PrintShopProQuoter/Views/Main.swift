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
		
		super.init(coder: aDecoder, rootView: Main(displayText: "This is only a test!", retrievedList: MainVC.fetchCompanies()))
	}
}

struct Main : View {
	
	private var displayText : String
	private var customerList : Customers?
	
	// Retrieved company list from coredata.
	private var retrievedList : [CoreCompany]?
	
	private var context : NSManagedObjectContext {
		let context = (UIApplication.shared.delegate as! AppDelegate)
			.persistentContainer.viewContext
		return context
	}
	
	var body : some View {
		
		Text(displayText)
			.onAppear {
				
				let restoredList = self.retrievedList!.map { item -> Company in
					Company(name: item.name!, address: Address(street: item.companyAddress?.street ?? "No Value"), id: item.id!)
				}
				self.customerList?.companies = restoredList
		}
	}
	
	init(displayText : String = "Text For Preview", retrievedList : [CoreCompany]? = nil) {
		self.displayText = displayText
		self.retrievedList = retrievedList
	}
	
	var body : some View {
		
		NavigationView{
			VStack{
				List(customerList.companies) { company in
					NavigationLink(destination: CompanyLandingPage(company: company)) {
						ItemRow(company: company)
					}
				}
			}
			.navigationBarTitle("Customer List")
			.navigationBarItems(trailing:
				AddCompanyNavigationBarTrailingButton(isPresentingView: $isPresentingView, customerList: customerList))
				.environment(\.managedObjectContext, self.context)
				.navigationBarTitle("Customer List")
		}
		.onAppear {
			
			let restoredList = self.retrievedList!.map { item -> Company in
				Company(name: item.name!, address: Address(street: item.companyAddress?.street ?? "No Value"), id: item.id!)
			}
			self.customerList.companies = restoredList
		}
	}
}

struct ItemRow: View {
	
	
	var company : Company
	
	var body: some View {
		HStack{
			VStack(alignment:.leading) {
				Text(company.name)
					.fontWeight(.heavy)
					.font(.headline)
					.foregroundColor(.blue)
				Text(company.address.street)
					.fontWeight(.light)
					.font(Font.system(size: 10))
			}
			
			Spacer()
			VStack{
				company.quotes?.count != nil ? Text(String(describing: company.quotes?.count)) : Text("0")
					.bold()
				Text("Quotes")
			}
			.padding()
			
			VStack{
				company.orders?.count != nil ? Text(String(describing: company.orders?.count)) : Text("0")
					.bold()
				Text("Orders")
			}
			.padding()
		}
	}
}

struct AddCompanyNavigationBarTrailingButton: View {
	
	@Binding var isPresentingView : Bool
	@Environment(\.managedObjectContext) var context
	
	var customerList : Customers
	
	var body: some View {
		HStack {
			Button(action: {
				self.isPresentingView = true
			}, label: {
				VStack{
					Image(systemName: "plus")
					Text("Add Customer")
						.font(Font.system(size: 10))
						.bold()
				}
			})
				.sheet(isPresented: $isPresentingView, content: {
					AddCompany().environment(\.managedObjectContext,self.context)
						.environmentObject(self.customerList)
				})
				.padding(.top, 5)
		}
	}
}


