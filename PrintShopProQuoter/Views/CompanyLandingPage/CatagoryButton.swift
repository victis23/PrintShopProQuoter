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
				if text != LOCATION {
					ButtonBaseLayer()
						.shadow(color: Color(UIColor(red: 0.0, green: 0.39, blue: 0.95, alpha: 1)),
								radius: 15, x: -5, y: -5)
						.opacity(0.8)
				}
				
				if text == LOCATION {
					ButtonBaseLayer()
						//Dark
						.shadow(color: Color(UIColor(red: 0.0, green: 0.39, blue: 0.95, alpha: 1)),
								radius: 10, x: -5, y: -5)
						//Light
						.shadow(color: Color(UIColor(red: 0.25, green: 0.81, blue: 1, alpha: 0.3)),
								radius: 15, x: 5, y: 15)
						.opacity(0.8)
				}
				
				GradientBackground()
					.mask(ButtonBaseLayer())
				
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
							
							ButtonIcon(text: text)
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
