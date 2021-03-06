//
//  Contact.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import Foundation

struct Contact : Codable , Identifiable {
	var name : String?
	var phone : String?
	var email : String?
	
	var id = UUID().uuidString
}
