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
import Introspect

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
		
		//FIXME: I wanted to use GradientBackground() to set the background of this view however when using this view whether in a Zstack or with the .background operator a bug was introduced that would stop the NavigationView's Title from having the proper animation and enter into inline mode when the user scrolled. Nothing would resolve this issue including using a scroll stack.
		
		NavigationView{
			
			//Creates list of current companies user has added to application.
			MainTableView(isPresentingView: $isPresentingView, customerList: customerList, deleteItems: deleteItems(at:))
				.introspectTableView(customize: {view in
					
					let gradientBuilder = BackgroundGradientSetter()
					let backgroundView = UIView()
					
					let gradientView = gradientBuilder.setGradientToView(with: [DarkBlueHue_DEFAULT, LightBlueHue_DEFAULT], size: view.frame)
					gradientView.center = backgroundView.center
					backgroundView.addSubview(gradientView)
					view.backgroundView = backgroundView
				})
				//Sets created GradientView as background.
//				.background(GradientBackground())
		}
		.navigationViewStyle(StackNavigationViewStyle())
			
			///When view appears use CoreData Objects to create an instance of Company for each item in array.
			/// - Note: `[CoreCompany] —> [Company]`
			.onAppear {
				let restoredList = self.retrievedList!.map { item -> Company in
					let fetcher = ContactListFetcher(managedObject: item)
					let contactList = fetcher.GetContactList()
					print("These are the items in our contact list: \(contactList)")
					return Company(name: item.name!,address: Address(street: item.companyAddress?.street ?? ERROR_NO_VALUE), contact: contactList, id: item.id!)
				}
				
				self.customerList.companies = restoredList
		}
	}
}

struct MainTableView: View {
	
	@Binding private var isPresentingView: Bool
	private var customerList : Customers
	private var deleteItems : (IndexSet)->Void
	
	init(isPresentingView: Binding<Bool>, customerList : Customers, deleteItems: @escaping (IndexSet)->Void){
		self._isPresentingView = isPresentingView
		self.customerList = customerList
		self.deleteItems = deleteItems
	}
	
	var body: some View {
		
		List{
			ForEach(customerList.companies) { company in
				
				NavigationLink(destination: CompanyLandingPage(company: company)) {
					
					CompanyListCell(company: company)
				}
			}
			.onDelete(perform: deleteItems)
		}
		.navigationBarTitle(CUSTOMER_LIST)
		.navigationBarItems(leading: AddCompanyNavigationBarTrailingButton(isPresentingView: $isPresentingView, customerList: customerList),
							trailing: EditButton())
			.foregroundColor(.white)
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
					AddCustomer()
						.environmentObject(self.customerList)
				})
				.padding(.top, 5)
		}
	}
}


