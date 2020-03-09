//
//  ButtonBaseLayer.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/9/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

/// Draws the basic shape of the button.
/// - Note: This view is the one that sets the color of the text.
struct ButtonBaseLayer: View {
	var body: some View {
		RoundedRectangle(cornerRadius: 10)
			.foregroundColor(Color(.white))
	}
}
