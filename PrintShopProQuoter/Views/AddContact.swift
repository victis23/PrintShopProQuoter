//
//  AddContact.swift
//  productionQuotePro
//
//  Created by Scott Leonard on 12/26/19.
//  Copyright © 2019 DuhMarket. All rights reserved.
//

import SwiftUI

///Holds view that will be setting contact details for `Company's Contact Property`.
struct AddContact: View {
	
	//Tracks and controls the state of the current view.
	@Environment(\.presentationMode) private var presentationMode
	
	//Property recieved from parent view.
	@Binding private var contact : Contact
	
	//Properties that will be assigned to the class instance contact property.
	@State private var name : String = ""
	@State private var phoneNumber : String = ""
	@State private var email : String = ""
	
	/// Initalizer that captures a binding property from parent view.
	init(contact: Binding<Contact>){
		self._contact = contact
	}
	
	var body: some View {
		
		ZStack{
			
			//Calls method that sets background color of current view to a gradient.
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
