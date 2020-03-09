//
//  ButtonIcon.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/9/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

/// Controls which image is set as button icon.
struct ButtonIcon: View {
	
	var text : String
	
	var body: some View {
		Image(text)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(alignment: .center)
	}
}

struct ButtonIcon_Preview : PreviewProvider {
	
	static var previews: some View {
		VStack{
			ButtonIcon(text: "Orders")
			ButtonIcon(text: "Quotes")
			ButtonIcon(text: "Location")
			ButtonIcon(text: "Contact Info")
		}
		.previewLayout(.sizeThatFits)
	}
}
