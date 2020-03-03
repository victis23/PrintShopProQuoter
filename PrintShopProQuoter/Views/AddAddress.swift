//
//  AddAddress.swift
//  productionQuotePro
//
//  Created by Scott Leonard on 12/26/19.
//  Copyright © 2019 DuhMarket. All rights reserved.
//

import SwiftUI

struct AddAddress: View {
	
	
	@Environment(\.presentationMode) private var presentationMode
	
	var body: some View {
		
		NavigationView{
			ZStack{
				GradientBackground()
				AddressForm()
			}
		}
		.navigationBarTitle("Address")
	}
}


struct AddressForm: View {
	
	@State  var street : String = ""
	@State  var city : String = ""
	@State  var state : String = ""
	@State  var country : String = ""
	@State  var zipcode : String = ""
	
	var body: some View {
		
		VStack{
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
			
			Button(action: {
				print(self.street)
			}) {
				Text("Save")
			}
		}
		.foregroundColor(.white)
	}
}

struct AddAddress_Previews: PreviewProvider {
	static var previews: some View {
		AddAddress()
	}
}
