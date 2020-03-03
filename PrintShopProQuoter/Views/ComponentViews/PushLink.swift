//
//  PushLink.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/3/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

struct PushLink<Content:View,Destination:View>: View {
	
	@Binding var isPresenting : Bool
	var content : () -> Content
	var destination : () -> Destination
	
	init(isPresenting:Binding<Bool>,
		 @ViewBuilder destination: @escaping () -> Destination,
					  @ViewBuilder content: @escaping () -> Content) {
		
		self.content = content
		self.destination = destination
		self._isPresenting = isPresenting
	}
	
	var body: some View {
		
		ZStack{
			if self.isPresenting {
				self.destination()
					.transition(.move(edge: .trailing))
			}
		}
	}
}

