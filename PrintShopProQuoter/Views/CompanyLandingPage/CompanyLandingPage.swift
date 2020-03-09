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
				
				CatagoryButton(company: company, text: CONTACT_INFO)
					.padding(.leading)
					.padding(.trailing)
				
				HStack {
					
					VStack {
						CatagoryButton(company: company, text: QUOTES)
						CatagoryButton(company: company, text: ORDERS)
					}
					
					VStack {
						CatagoryButton(company: company, text: LOCATION)
					}
				}
				.padding()
				
			}
		}
		.navigationBarTitle(company?.name ?? NO_COMPANY_DEFAULT_STRING)
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
