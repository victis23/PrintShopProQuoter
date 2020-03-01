//
//  ViewController.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import UIKit
import SwiftUI

class MainVC : UIHostingController<MainView> {

	override init?(coder aDecoder: NSCoder, rootView: MainView) {
		super.init(coder: aDecoder, rootView: rootView)
	}
	
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder, rootView: MainView())
	}
}

struct MainView : View {
	
	var body : some View {
		
		Text("Time to start work!")
	}
}


struct ViewController_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
