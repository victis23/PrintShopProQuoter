//
//  AddContact.swift
//  productionQuotePro
//
//  Created by Scott Leonard on 12/26/19.
//  Copyright © 2019 DuhMarket. All rights reserved.
//

import SwiftUI

struct AddContact: View {
	
	@Environment(\.presentationMode) private var presentationMode
	@Binding private var contact : Contact
	@State private var name : String = ""
	@State private var phoneNumber : String = ""
	@State private var email : String = ""
	
	init(contact: Binding<Contact>){
		self._contact = contact
	}
	
	var body: some View {
		
		ZStack{
			
			GradientBackground()
			
			VStack{
				
				Form{
					
					TextField("Name", text: $name)
					.padding()
					
					TextField("Phone Number", text: $phoneNumber)
					.padding()
					
					TextField("Email", text: $email)
					.padding()
				}
				.foregroundColor(.white)
				
				Button(action: {
					self.contact.name = self.name
					self.contact.phone = self.phoneNumber
					self.contact.email = self.email
					self.presentationMode.wrappedValue.dismiss()
					
				}) {
					
					Text("Submit")
						.foregroundColor(.white)
				}
			}
		}
	}
}

struct AddContact_Previews: PreviewProvider {
	static var previews: some View {
		AddContact(contact: .constant(Contact()))
	}
}
