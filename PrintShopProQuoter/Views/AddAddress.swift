//
//  AddAddress.swift
//  productionQuotePro
//
//  Created by Scott Leonard on 12/26/19.
//  Copyright © 2019 DuhMarket. All rights reserved.
//

import SwiftUI

struct AddAddress: View {
	
	@State private var street : String = ""
	@State private var city : String = ""
	@State private var state : String = ""
	@State private var country : String = ""
	@State private var zipcode : String = ""
	
	@Environment(\.presentationMode) private var presentationMode
	
	var body: some View {
		
		NavigationView{
			ZStack{
				GradientBackground()
				VStack{
					AddressForm(street: $street, city: $city, state: $state, country: $country, zipcode: $zipcode)
					Button(action: {
						print(self.street)
						self.presentationMode.wrappedValue.dismiss()
					}) {
						Text("Submit")
					}
				}
				.foregroundColor(.white)
			}
		}
		.navigationBarTitle("Address")
	}
}


struct AddressForm: View {
	
	@Binding private var street : String
	@Binding private var city : String
	@Binding private var state : String
	@Binding private var country : String
	@Binding private var zipcode : String
	
	init(street:Binding<String>, city: Binding<String>, state: Binding<String>, country : Binding<String>, zipcode: Binding<String>){
		self._street = street
		self._city = city
		self._state = state
		self._country = country
		self._zipcode = zipcode
	}
	
	var body: some View {
		
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
		AddAddress()
	}
}
