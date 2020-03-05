//
//  AddCustomer.swift
//  productionQuotePro
//
//  Created by Scott Leonard on 12/26/19.
//  Copyright © 2019 DuhMarket. All rights reserved.
//

import SwiftUI
import CoreData

struct AddCompany: View {
	
	@Environment(\.presentationMode) private var presentationMode
	@Environment(\.managedObjectContext) private var context
	
	@EnvironmentObject private var customerList : Customers
	
	@State private var name = ""
	@State private var address : Address = Address(street: nil, city: nil, state: nil, country: nil, zipcode: nil)
	@State private var contact : Contact = Contact()
	
	var body: some View {
		
		NavigationView {
			ZStack{
				GradientBackground()
				
				VStack{
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
					
					Button(action: {
						let newCompany = Company(name: self.name, address: self.address, contact: self.contact, quotes: nil, orders: nil)
						
						self.customerList.companies.append(newCompany)
						
						let company = CoreCompany(context: self.context)
						company.name = newCompany.name
						company.id = newCompany.id
						company.companyAddress = CoreAddress(context: self.context)
						company.companyAddress?.street = newCompany.address?.street
						company.companyAddress?.city = newCompany.address?.city
						company.companyAddress?.state = newCompany.address?.state
						company.companyAddress?.country = newCompany.address?.country
						company.companyAddress?.zipcode = newCompany.address?.zipcode
						
						try? self.context.save()
						
						self.presentationMode.wrappedValue.dismiss()
						
					}, label: {
						
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
