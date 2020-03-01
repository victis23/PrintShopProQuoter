//
//  Quote.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import Foundation

struct Quotes {
	var jobCatagory : Catagory
	var jobName : String
	var description : String
	var purchaseOrder : Int?
	var quantity : Int
	var totalSheets : Int
	var stockColor : StockColors
	var stockWeight : StockWeight
	var stockFinish : StockFinish
	var orderNumber : Int
}
