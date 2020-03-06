//
//  AddCustomer.swift
//  productionQuotePro
//
//  Created by Scott Leonard on 12/26/19.
//  Copyright © 2019 DuhMarket. All rights reserved.
//

import SwiftUI

/// View that allows user to add a company to main view.
struct AddCompany: View {
	
	//Tracks current state of view and dismissal.
	@Environment(\.presentationMode) private var presentationMode
	
	//Holds Instance of observable object held in the apps environment.
	@EnvironmentObject private var customerList : Customers
	
	//Properties that will be assigned to the instance of Company when user taps submit button..
	@State private var name = ""
	@State private var address : Address = Address(street: nil, city: nil, state: nil, country: nil, zipcode: nil)
	@State private var contact : Contact = Contact()
	
	var body: some View {
		
		NavigationView {
			
			ZStack{
				
				// Sets background gradient color for current view.
				GradientBackground()
				
				VStack{
					
					///List that handles fields for user input.
					List(content: {
						
						TextField("Company Name", text: $name)
							.padding()
						
						NavigationLink(destination: AddAddress(address: $address), label: {
							Text("Address")
								.padding(.all, 20)
						})
						
						NavigationLink(destination: AddContact(contact: $contact), label: {
							Text("Contact Info")
								.padding(.all, 20)
						})
					})
						.foregroundColor(.white)
					
					Spacer()
					
					///Handles `save new company` button.
					Button(action: {
						
						//Creates instance of Company using user input.
						let newCompany = Company(name: self.name, address: self.address, contact: self.contact, quotes: nil, orders: nil)
						
						//Created company is appended to observable object class that will be displayed on customer list page.
						self.customerList.companies.append(newCompany)
						
						//Create instance of company saver that controls saving values to coredata.
						let companySaver = CompanySaver(company: newCompany)
						
						//Save to persistant container.
						companySaver.set()
						
						//Dismiss current view.
						self.presentationMode.wrappedValue.dismiss()
						
					}, label: {
						
						/// Views for drawing save button and its corresponding label.
						ZStack {
							
							RoundedRectangle(cornerRadius: 10	 , style: .continuous)
								.foregroundColor(.white)
								.frame(height: 75, alignment: .center)
								.shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)), radius: 10, x: 0, y: 10)
							
							Text("Save New Company")
								.font(.largeTitle)
								.foregroundColor(Color(.link))
								.bold()
								.padding(.horizontal, 10)
							
						}
					})
						.padding()
				}
			}
			.navigationBarTitle("Add Company")
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}


struct AddCustomer_Previews: PreviewProvider {
	static var previews: some View {
		AddCompany()
	}
}
