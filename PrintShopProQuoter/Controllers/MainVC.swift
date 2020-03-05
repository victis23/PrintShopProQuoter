//
//  MainController.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//


import SwiftUI

class MainVC : UIHostingController<Main> {
	
	override init?(coder aDecoder: NSCoder, rootView: Main) {
		super.init(coder: aDecoder, rootView: rootView)
	}
	
	///Uses array of Coredata objects to instantiate `Main`.
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder, rootView: Main(retrievedList: CompanyFetcher().fetchFromCoreData()))
	}
}
