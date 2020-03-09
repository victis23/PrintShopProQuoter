//
//  ButtonShadowLayer.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/9/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI


struct ButtonShadowLayer: View {
	
	private var text : String
	
	init(text:String){
		self.text = text
	}
	
	var body: some View {
		Group{
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
		}
	}
}
