//
//  CompanyLandingPage.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

struct CompanyLandingPage : View {
	
	private var company : Company?
	
	init(company : Company? = nil){
		self.company = company
	}
	
	var body: some View {
		
		NavigationView{
			ZStack {
				GradientBackground()
				VStack{
					ItemButton(company: company, text: "Contact Info")
						.padding(.leading)
						.padding(.trailing)
					HStack {
						VStack {
							ItemButton(company: company, text: "Quotes")
							ItemButton(company: company, text: "Orders")
						}
						VStack {
							ItemButton(company: company, text: "Location")
						}
					}
					.padding()
				}
			}
		}
		.navigationBarTitle(company?.name ?? "No Company")
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
				RoundedRectangle(cornerRadius: 10)
					.foregroundColor(Color(.white))
				
				VStack{
					Text(text)
						.foregroundColor(Color(.link))
						.bold()
						.padding(.top)
					
					if text == "Contact Info" {
						Image(text)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 150, height: 150, alignment: .center)
						Spacer()
					}else{
						
						Image(text)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 100, height: 100, alignment: .center)
					}
				}
				.padding(.bottom)
			}
		}
		.sheet(isPresented: $isPresenting, content: {
			UIKitWrapper(company: self.company!, storyboardPointer: self.text)
		})
	}
}


struct Preview : PreviewProvider {
	
	static var previews: some View {
		CompanyLandingPage()
			.previewDevice("iPhone Xs")
			.colorScheme(.light)
		//			.previewLayout(.sizeThatFits)
	}
}

