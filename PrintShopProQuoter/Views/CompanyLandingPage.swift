//
//  CompanyLandingPage.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

///View that allows user to access contact information, location, quotes & orders.
struct CompanyLandingPage : View {
	
	private var company : Company?
	
	//Injects instance of Company to instance property company.
	init(company : Company? = nil){
		self.company = company
	}
	
	var body: some View {
		
		ZStack {
			
			//Sets background gradient for current view.
			GradientBackground()
			
			VStack{
				
				ItemButton(company: company, text: CONTACT_INFO)
					.padding(.leading)
					.padding(.trailing)
				
				HStack {
					
					VStack {
						ItemButton(company: company, text: QUOTES)
						ItemButton(company: company, text: ORDERS)
					}
					
					VStack {
						ItemButton(company: company, text: LOCATION)
					}
				}
				.padding()
				
			}
		}
		.navigationBarTitle(company?.name ?? NO_COMPANY_DEFAULT_STRING)
	}
}

struct ItemButton: View {
	
	@State var isPresenting :Bool = false
	
	var company : Company?
	var text : String
	var body: some View {
		
		Button(action: {
			self.isPresenting.toggle()
		}){
			
			ZStack {
				if text != LOCATION {
				ButtonBackground()
					.shadow(color: Color(UIColor(red: 0.0, green: 0.39, blue: 0.95, alpha: 1)),
							radius: 15, x: -5, y: -5)
					.opacity(0.8)
				}
				
				if text == LOCATION {
					ButtonBackground()
						//Dark
						.shadow(color: Color(UIColor(red: 0.0, green: 0.39, blue: 0.95, alpha: 1)),
								radius: 10, x: -5, y: -5)
						//Light
						.shadow(color: Color(UIColor(red: 0.25, green: 0.81, blue: 1, alpha: 0.3)),
								radius: 15, x: 5, y: 15)
						.opacity(0.8)
				}
				
				GradientBackground()
					.mask(ButtonBackground())
				
				VStack{
					
					//Checks which button is being drawn. Contact Info button is the primary button on this view so it needs to have a larger version of its icon drawn.
					if text == CONTACT_INFO {
						
						ZStack{
							
							Circle()
								.stroke(Color.white, lineWidth: 5)
								.foregroundColor(.white)
							
							Image(text)
								.resizable()
								.aspectRatio(contentMode: .fit)
						}
						.padding()
						
						Text(text)
							.foregroundColor(Color(.white))
							.bold()
							.font(.title)
							.padding(.top)
						Spacer()
					}
						
					else {
						Text(text)
							.foregroundColor(Color(.white))
							.bold()
							.padding(.top)
						
						ZStack{
							
							if text == QUOTES {
								Circle()
									.foregroundColor(.white)
							}
							
							if text == ORDERS {
								Circle()
									.stroke(Color.white, lineWidth: 2)
									.foregroundColor(.white)
							}
							
							SmallImages(text: text)
								.aspectRatio(contentMode: .fit)
						}
					}
				}
				.padding(.bottom)
			}
		}
		.sheet(isPresented: $isPresenting) {
			UIKitWrapper(company: self.company!, storyboardPointer: self.text)
		}
	}
}

struct ButtonBackground: View {
	var body: some View {
		RoundedRectangle(cornerRadius: 10)
			.foregroundColor(Color(.white))
	}
}

struct SmallImages: View {
	
	var text : String
	
	var body: some View {
		Image(text)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(alignment: .center)
	}
}

//MARK: -
struct Preview : PreviewProvider {
	
	static var previews: some View {
		CompanyLandingPage()
			.previewDevice("iPhone Xs")
			.colorScheme(.light)
		//			.previewLayout(.sizeThatFits)
	}
}
