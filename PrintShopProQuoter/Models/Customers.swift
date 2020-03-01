//
//  Customers.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import Foundation

/// Holds and publishes a list of companies that user adds to app.
class Customers : ObservableObject {
	@Published var companies : [Company] = []
}
