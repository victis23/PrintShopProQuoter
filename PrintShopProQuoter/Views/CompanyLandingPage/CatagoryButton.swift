//
//  CatagoryButton.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/9/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

/// Controls the actual action performed by the button upon taps.
struct CatagoryButton: View {
	
	@State var isPresenting :Bool = false
	
	var company : Company?
	var text : String
	
	var body: some View {
		
		NavigationLink(destination: UIKitWrapper(company: self.company, storyboardPointer: self.text)
			.edgesIgnoringSafeArea(.all)
			.navigationBarTitle(self.text),
					   isActive: self.$isPresenting,
					   label: {
			
			Button(action: {
				self.isPresenting.toggle()
				
			}){
				
				ZStack {
					
					ButtonShadowLayer(text: text)
					
					GradientBackground()
						.mask(ButtonBaseLayer())
					
					CircleAndTextLayer(text: text)
				}
			}
		})
	}
}


