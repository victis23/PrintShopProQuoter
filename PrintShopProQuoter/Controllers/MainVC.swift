//
//  MainController.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//


import SwiftUI

//Hosts a view that will contain a struct class that conforms to swiftUI's View protocol.
class MainVC : UIHostingController<Main> {
	
	///1. — Uses array of Coredata objects to instantiate `Main`.
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder, rootView: Main(retrievedList: CompanyFetcher().fetchFromCoreData()))
	}
	
	///2. — Called by `@objc required dynamic init?` to construct view.
	override init?(coder aDecoder: NSCoder, rootView: Main) {
		super.init(coder: aDecoder, rootView: rootView)
	}
}
