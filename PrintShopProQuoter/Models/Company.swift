//
//  File.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import Foundation

struct Company : Identifiable, Hashable {
	
	var name : String?
	var address : Address?
	var contact : Contact?
	var quotes : [Quotes]?
	var orders : [Orders]?
	
	var id: String = UUID().uuidString
	
	static func == (lhs: Company, rhs: Company) -> Bool {
		lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
