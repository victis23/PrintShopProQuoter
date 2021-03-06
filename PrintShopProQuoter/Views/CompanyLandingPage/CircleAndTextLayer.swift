//
//  ButtonIconLayer.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/9/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

/// Checks which button is being drawn. Contact Info button is the primary button on this view so it needs to have a larger version of its icon drawn.
/// - Important: `Location` button is not included in the buttons that recieve a circle under their icon.
/// - Note: `Contact Info` button has image above description instead of below as do the other buttons.
struct CircleAndTextLayer: View {
	
	private var text : String
	
	init(text:String){
		self.text = text
	}
	
	var body: some View {
		VStack{
			
			if text == CONTACT_INFO {
				
				ZStack{
					
					Group{
						Circle()
							.stroke(Color.white, lineWidth: 5)
							.foregroundColor(.white)
						
						ButtonIcon(text: text)
					}
					.padding(.top)
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
					
					//This is not used for Contact Info because that button requires different padding.
					ButtonIcon(text: text)
						.aspectRatio(contentMode: .fit)
				}
			}
		}
		.padding(.bottom)
	}
}
