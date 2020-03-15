//
//  AddContact.swift
//  productionQuotePro
//
//  Created by Scott Leonard on 12/26/19.
//  Copyright © 2019 DuhMarket. All rights reserved.
//

import SwiftUI
import Introspect

///Holds view that will be setting contact details for `Company's Contact Property`.
struct AddContact: View {
	
	//Tracks and controls the state of the current view.
	@Environment(\.presentationMode) private var presentationMode
	
	//Property recieved from parent view.
	@Binding private var contact : [Contact]
	
	//Properties that will be assigned to the class instance contact property.
	@State private var name : String = BLANK
	@State private var phoneNumber : String = BLANK
	@State private var email : String = BLANK
	
	/// Initalizer that captures a binding property from parent view.
	init(contact: Binding<[Contact]>){
		self._contact = contact
	}
	
	var body: some View {
		
		ZStack{
			
			//Calls method that sets background color of current view to a gradient.
			GradientBackground()
			
			VStack{
				
				Form{
					
					TextField(NAME, text: $name)
						.padding()
					
					TextField(PHONE_NUMBER, text: $phoneNumber)
						.padding()
					
					TextField(EMAIL, text: $email)
						.padding()
				}
				.foregroundColor(.white)
				
				Button(action: {
					
					var createdContact = Contact()
					createdContact.name = self.name
					createdContact.phone = self.phoneNumber
					createdContact.email = self.email
					self.contact.append(createdContact)
					self.presentationMode.wrappedValue.dismiss()
					
				}) {
					
					Text(SUBMIT)
						.foregroundColor(.white)
				}
				
			}
		}
		.navigationBarTitle(CONTACT)
	}
	
	func resetTextFields(){
		self.name = BLANK
		self.email = BLANK
		self.phoneNumber = BLANK
	}
}

struct ContactList_TableView : View {
	
	@Binding private var contact : [Contact]
	
	init(contact:Binding<[Contact]>){
		self._contact = contact
	}
	
	var body: some View {
		List {
			ForEach(contact, content: { contact in
				Text(contact.name ?? "")
					.foregroundColor(Color(UIColor(cgColor: DarkBlueHue_DEFAULT)))
					.fontWeight(.bold)
					.font(.title)
					.padding()
			})
				.onDelete(perform: removeContact(_:))
		}
		.introspectTableView(customize: { tableView in
			tableView.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.4)
			tableView.layer.cornerRadius = 10
			tableView.separatorStyle = .none
			tableView.separatorColor = .clear
		})
	}
	
	//Same as Optional<(IndexSet)->Void> just cleaner in my opinion.
	func removeContact(_ index : IndexSet){
		self.contact.remove(atOffsets: index)
	}
}

struct AddContact_Previews: PreviewProvider {
	static var previews: some View {
		AddContact(contact: .constant([Contact()]))
	}
}
