//
//  AddAddress.swift
//  productionQuotePro
//
//  Created by Scott Leonard on 12/26/19.
//  Copyright © 2019 DuhMarket. All rights reserved.
//

import SwiftUI

/// View that allows user to add and address to AddCustomer's environmental object Company...
struct AddAddress: View {
	
	//Tracks and controls the state of the current view.
	@Environment(\.presentationMode) private var presentationMode
	
	//Property recieved from parent view.
	@Binding private var address : Address
	
	//Properties that will be assigned to the class instance address property.
	@State private var street : String = BLANK
	@State private var city : String = BLANK
	@State private var state : String = BLANK
	@State private var country : String = BLANK
	@State private var zipcode : String = BLANK
	
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
						SmallCircle_Button(imageName: "tray.and.arrow.down.fill")
					}
				}
				.foregroundColor(.white)
		}
		.navigationBarTitle(ADDRESS)
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
			TextField(STREET, text: $street)
				.padding()
			TextField(CITY, text: $city)
				.padding()
			TextField(STATE, text: $state)
				.padding()
			TextField(COUNTRY, text: $country)
				.padding()
			TextField(ZIPCODE, text: $zipcode)
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
