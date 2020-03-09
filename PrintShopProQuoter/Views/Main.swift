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
	
	// This value is set in MainVC.swift.
	init(retrievedList : [CoreCompany]? = nil) {
		self.retrievedList = retrievedList
	}
	
	///Selects item that will be removed during edit mode from list.
	/// [S]OLID — Deleter handles actual deleting of selected object from persistent container.
	func deleteItems(at index : IndexSet){
		
		// returns index for selected row in ForEach view while in edit mode.
		guard let position = index.first else {return}
		
		// returns string value for item's identifier.
		let id = customerList.companies[position].id
		
		// Uses instance of Deleter class to remove queried item.
		do{
			let deleter = Deleter(identifier: id, keypath: \CoreCompany.name, CDType: NSFetchRequest<CoreCompany>(entityName: CORE_COMPANY), filter: "id = %@")
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
				
				//Makes the background of the view the app's custom blue gradient.
				GradientBackground()
				
				VStack{
					
					//Creates list of current companies user has added to application.
					List{
						ForEach(customerList.companies) { company in
							
							NavigationLink(destination: CompanyLandingPage(company: company)) {
								
								CompanyListCell(company: company)
							}
							}
						.onDelete(perform: deleteItems)
						.listRowBackground(Color.clear)
					}
				}
				.navigationBarTitle(CUSTOMER_LIST)
				.navigationBarItems(leading:
					
					AddCompanyNavigationBarTrailingButton(isPresentingView: $isPresentingView, customerList: customerList), trailing: EditButton())
					.foregroundColor(.white)
					.navigationBarTitle(CUSTOMER_LIST)
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
			
			///When view appears use CoreData Objects to create an instance of Company for each item in array.
			/// - Note: `[CoreCompany] —> [Company]`
			.onAppear {
				let restoredList = self.retrievedList!.map { item -> Company in
					Company(name: item.name!, address: Address(street: item.companyAddress?.street ?? ERROR_NO_VALUE), id: item.id!)
				}
				
				self.customerList.companies = restoredList
		}
	}
}

struct CompanyListCell: View {
	
	
	var company : Company
	
	var body: some View {
		
		HStack{
			
			VStack(alignment:.leading) {
				
				Text(company.name ?? ERROR_NO_VALUE)
					.fontWeight(.heavy)
					.font(.headline)
				
				Text(company.address?.street ?? ERROR_NO_VALUE)
					.fontWeight(.light)
					.font(Font.system(size: 10))
			}
			
			Spacer()
			
			VStack{
				company.quotes?.count != nil ? Text(String(describing: company.quotes?.count)) : Text("0")
					.bold()
				Text(QUOTES)
			}
			.padding()
			
			VStack{
				company.orders?.count != nil ? Text(String(describing: company.orders?.count)) : Text("0")
					.bold()
				Text(ORDERS)
			}
			.padding()
		}
	}
}

struct AddCompanyNavigationBarTrailingButton: View {
		
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
					
					Text(ADD_CUSTOMER)
						.font(Font.system(size: 10))
						.bold()
				}
			})
				.sheet(isPresented: $isPresentingView, content: {
					AddCompany()
						.environmentObject(self.customerList)
				})
				.padding(.top, 5)
		}
	}
}


