//
//  QuotesViewController.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/4/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController, AccessControllerProtocol {
	
	var company : Company!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setGradientBackground()
	}
	
	func setGradientBackground(){
		let backgroundSetter = BackgroundGradientSetter()
		let subView = backgroundSetter.setGradientToView(with: [DarkBlueHue_DEFAULT,LightBlueHue_DEFAULT],size: view.bounds)
		
		view.addSubview(subView)
		view.sendSubviewToBack(subView)
	}
}
