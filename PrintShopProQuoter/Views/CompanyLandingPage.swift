//
//  CompanyLandingPage.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

struct CompanyLandingPage : View {
	var company : Company?
	
	var body: some View {
		Text(company?.name ?? "No EnteredValue")
	}
}

struct Preview : PreviewProvider {
	
	static var previews: some View {
		CompanyLandingPage()
	}
}
