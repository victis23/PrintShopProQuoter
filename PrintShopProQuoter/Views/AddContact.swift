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
				
				
				Divider()
					.foregroundColor(.white)
					.shadow(color: .black, radius: 5, x: 0, y: -10)
				
				ContactList_TableView(contact: $contact)
					.padding()
				
				HStack{
					
					//Adds contact to array of contacts.
					Button(action: {
						
						var createdContact = Contact()
						createdContact.name = self.name
						createdContact.phone = self.phoneNumber
						createdContact.email = self.email
						self.contact.append(createdContact)
						
						self.resetTextFields()
					}) {
						
						AddContact_Button(text: SUBMIT)
					}
					
					//Adds array of contacts to Company object.
					Button(action: {
						self.presentationMode.wrappedValue.dismiss()
					}, label: {
						
						AddContact_Button(text: "Save")
					})
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
				HStack{
					
					Text(contact.name ?? "")
						.foregroundColor(Color(UIColor(cgColor: DarkBlueHue_DEFAULT)))
						.fontWeight(.bold)
						.font(.title)
						.padding()
					
					Spacer()
					
					VStack{
						Text(contact.phone ?? "")
							.foregroundColor(Color(UIColor(cgColor: LightBlueHue_DEFAULT)))
							.fontWeight(.heavy)
							.font(.body)
							.padding(.trailing)
						
						Text(contact.email ?? "")
							.foregroundColor(Color(UIColor(cgColor: LightBlueHue_DEFAULT)))
							.fontWeight(.heavy)
							.font(.body)
							.padding(.trailing)
					}
				}
			})
				.onDelete(perform: removeContact(_:))
		}
		.introspectTableView(customize: { tableView in
			
			tableView.separatorStyle = .none
			tableView.separatorColor = .clear
			
			tableView.visibleCells.forEach({
				$0.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.4)
				$0.layer.cornerRadius = 10
				let view = UIView()
				view.layer.cornerRadius = 10
				view.backgroundColor = .white
				view.frame = CGRect(x: 0, y: 0, width: $0.contentView.frame.width - 10, height: $0.contentView.frame.height - 10)
				view.center = $0.contentView.center
				$0.contentView.addSubview(view)
				$0.contentView.sendSubviewToBack(view)
			})
		})
	}
	
	//Same as Optional<(IndexSet)->Void> just cleaner in my opinion.
	func removeContact(_ index : IndexSet){
		self.contact.remove(atOffsets: index)
	}
}

struct AddContact_Button: View {
	
	private var text : String
	
	init(text:String){
		self.text = text
	}
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10)
				.fill(Color.white)
				.padding()
				.frame(height: 100, alignment: .leading)
			
			Text(text)
				.foregroundColor(Color(UIColor(cgColor: DarkBlueHue_DEFAULT)))
				.fontWeight(.bold)
				.font(.largeTitle)
		}
	}
}

struct AddContact_Previews: PreviewProvider {
	static var previews: some View {
		AddContact(contact: .constant([Contact()]))
	}
}
