//
//  CatagoryButton.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/9/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI


struct CatagoryButton: View {
	
	@State var isPresenting :Bool = false
	
	var company : Company?
	var text : String
	var body: some View {
		
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
		.sheet(isPresented: $isPresenting) {
			UIKitWrapper(company: self.company!, storyboardPointer: self.text)
		}
	}
}



