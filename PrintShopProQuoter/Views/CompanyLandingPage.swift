//
//  CompanyLandingPage.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

struct CompanyLandingPage : View {
	var company : Company?
	
	var body: some View {
		NavigationView{
			HStack {
				VStack {
					ItemButton(company: company, text: "Quotes")
					ItemButton(company: company, text: "Orders")
					Spacer()
				}
				VStack {
					ItemButton(company: company, text: "Contact Info")
					ItemButton(company: company, text: "Location")
					Spacer()
				}
			}
		.padding()
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
			self.isPresenting = true
		}){
			ZStack {
				RoundedRectangle(cornerRadius: 10)
					.aspectRatio(contentMode: .fit)
					.foregroundColor(Color(.secondarySystemFill))
				Text(text)
					.foregroundColor(Color(.label))
					.bold()
			}
		}
	}
}
struct Preview : PreviewProvider {
	
	static var previews: some View {
		CompanyLandingPage()
	}
}
