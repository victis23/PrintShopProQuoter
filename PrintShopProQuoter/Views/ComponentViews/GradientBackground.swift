//
//  GradientBackground.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

struct GradientBackground: View {
	var body: some View {
		AngularGradient(gradient: Gradient(colors: [
			Color(UIColor(red: 0.25, green: 0.81, blue: 1, alpha: 0.3)),
			Color(UIColor(red: 0.0, green: 0.39, blue: 0.95, alpha: 1))
		]),
						center: .bottomLeading,
						angle: Angle(degrees: 0.45))
			.edgesIgnoringSafeArea(.all)
	}
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
    }
}
