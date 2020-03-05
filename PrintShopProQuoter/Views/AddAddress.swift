//
//  AddAddress.swift
//  productionQuotePro
//
//  Created by Scott Leonard on 12/26/19.
//  Copyright © 2019 DuhMarket. All rights reserved.
//

import SwiftUI

/// View that allows user to add and address to AddCompany's environmental object Company...
struct AddAddress: View {
	
	//Tracks and controls the state of the current view.
	@Environment(\.presentationMode) private var presentationMode
	
	//Property recieved from parent view.
	@Binding private var address : Address
	
	//Properties that will be assigned to the class instance address property.
	@State private var street : String = ""
	@State private var city : String = ""
	@State private var state : String = ""
	@State private var country : String = ""
	@State private var zipcode : String = ""
	
	//Captures Binding Address from Parent view.
	init(address: Binding<Address>){
		self._address = address
	}
	
	var body: some View {
		
			ZStack{
				
				//Set background to gradient.
				GradientBackground()
				
				VStack{
					
					//Calls instance of AddressForm which presents a form on parent view that access user input for given properties.
					AddressForm(street: $street, city: $city, state: $state, country: $country, zipcode: $zipcode)
					
					//Sets values to address property using gathered user input.
					Button(action: {
						self.address.street = self.street
						self.address.city = self.city
						self.address.state = self.state
						self.address.country = self.country
						self.address.zipcode = self.zipcode
						
						//Dismiss current view.
						self.presentationMode.wrappedValue.dismiss()
					}) {
						Text("Submit")
					}
				}
				.foregroundColor(.white)
		}
		.navigationBarTitle("Address")
	}
}


struct AddressForm: View {
	
	// Binding properties recieved from parent view.
	@Binding private var street : String
	@Binding private var city : String
	@Binding private var state : String
	@Binding private var country : String
	@Binding private var zipcode : String
	
	//Assigns rawvalues to struct properties.
	init(street:Binding<String>, city: Binding<String>, state: Binding<String>, country : Binding<String>, zipcode: Binding<String>){
		self._street = street
		self._city = city
		self._state = state
		self._country = country
		self._zipcode = zipcode
	}
	
	var body: some View {
		
		///Handles textfields for user input.
		Form{
			TextField("Street", text: $street)
				.padding()
			TextField("City", text: $city)
				.padding()
			TextField("State", text: $state)
				.padding()
			TextField("Country", text: $country)
				.padding()
			TextField("Zipcode", text: $zipcode)
				.padding()
		}
		.font(.title)
	}
}

struct AddAddress_Previews: PreviewProvider {
	
	static var previews: some View {
		AddAddress(address: .constant(Address(street: nil, city: nil, state: nil, country: nil, zipcode: nil)))
	}
}
