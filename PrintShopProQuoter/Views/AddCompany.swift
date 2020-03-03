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
	@State private var address : Address = Address(street: "Default", city: nil, state: nil, country: nil, zipcode: nil)
	@State private var contact = "Defalut Contact Name"
	
	var body: some View {
		
		NavigationView {
			ZStack{
				GradientBackground()
				VStack{
					List(content: {
						
						TextField("Company Name", text: $name)
							.padding()
						
						NavigationLink(destination: AddAddress(), label: {
							Text("Address")
								.padding(.all, 20)
						})
						
						NavigationLink(destination: AddContact(), label: {
							Text("Contact Info")
								.padding(.all, 20)
						})
					})
						.foregroundColor(.white)
					Spacer()
					
					Button(action: {
						let newCompany = Company(name: self.name, address: self.address, contact: Contact(name: self.contact), quotes: nil, orders: nil)
						self.customerList.companies.append(newCompany)
						
						
						let company = CoreCompany(context: self.context)
						company.name = newCompany.name
						company.id = newCompany.id
						let address = CoreAddress(context: self.context)
						address.street = newCompany.address?.street
						company.companyAddress?.street = address.street
						try? self.context.save()
						
						
						self.presentationMode.wrappedValue.dismiss()
					}, label: {
						ZStack {
							Capsule()
								.frame(minWidth: 250, idealWidth: 265, maxWidth: 350, minHeight: 50, idealHeight: 55, maxHeight: 60, alignment: .center)
								.foregroundColor(.white)
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
	}
}


struct AddCustomer_Previews: PreviewProvider {
	static var previews: some View {
		AddCompany()
	}
}
