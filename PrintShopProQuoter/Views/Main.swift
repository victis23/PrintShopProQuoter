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

/// Handles view that contains a list of current companies user is doing business with.
struct Main : View {
	
	@ObservedObject private var customerList: Customers = Customers()
	
	@State private var isPresentingView = false
	
	// Retrieved company list from coredata assigned in MainVC().
	private var retrievedList : [CoreCompany]?
	
	// Retrieves and saves reference to persistent container that will be passed to subsequent views.
	private var context : NSManagedObjectContext {
		let context = (UIApplication.shared.delegate as! AppDelegate)
			.persistentContainer.viewContext
		return context
	}
	
	init(retrievedList : [CoreCompany]? = nil) {
		self.retrievedList = retrievedList
	}
	
	///Selects item that will be removed during edit mode from list.
	/// [S]OLID — CompanyDeleter handles actual deleting of selected object from persistent container.
	func deleteItems(at index : IndexSet){
		
		// returns index for selected row in ForEach view while in edit mode.
		guard let position = index.first else {return}
		
		// returns string value for item's identifier.
		let id = customerList.companies[position].id
		
		do{
			let deleter = CompanyDeleter(identifier: id, context: context)
			try deleter?.removeObject()
		}
		catch(let e){
			print(e.localizedDescription)
		}
		
		// Removes item from current list.
		customerList.companies.remove(atOffsets: index)
	}
	
	var body : some View {
		
		NavigationView{
			
			ZStack{
				
				GradientBackground()
				
				VStack{
					
					//Creates list of current companies user has added to application.
					List{
						ForEach(customerList.companies) { company in
							
							NavigationLink(destination: CompanyLandingPage(company: company)) {
								
								ItemRow(company: company)
							}
							}
						.onDelete(perform: deleteItems)
						.listRowBackground(Color.clear)
					}
				}
				.navigationBarTitle("Customer List")
				.navigationBarItems(leading:
					
					AddCompanyNavigationBarTrailingButton(isPresentingView: $isPresentingView, customerList: customerList), trailing: EditButton())
					.foregroundColor(.white)
					.environment(\.managedObjectContext, self.context)
					.navigationBarTitle("Customer List")
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
			
			///When view appears use CoreData Objects to create an instance of Company for each item in array.
			/// - Note: `[CoreCompany] —> [Company]`
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
				
				Text(company.name ?? "Error No Value")
					.fontWeight(.heavy)
					.font(.headline)
				
				Text(company.address?.street ?? "Error No Value")
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
	
	//Instance property that holds reference to persistent container context.
	@Environment(\.managedObjectContext) var context
	
	//Determines if view is being presented or not.
	@Binding var isPresentingView : Bool
	
	var customerList : Customers
	
	var body: some View {
		
		HStack {
			
			Button(action: {
				self.isPresentingView.toggle()
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


