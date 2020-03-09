//
//  ButtonIcon.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/9/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

struct ButtonIcon: View {
	
	var text : String
	
	var body: some View {
		Image(text)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(alignment: .center)
	}
}
