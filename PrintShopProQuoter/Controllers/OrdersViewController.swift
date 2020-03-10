//
//  OrdersViewController.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/4/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController, AccessControllerProtocol {
	
	var company : Company!
	@IBOutlet var companyNameLabel : UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setBackgroundColor()
		companyNameLabel.text = company.name
	}
	
	func setBackgroundColor(){
		
		let backgroundGradient = BackgroundGradientSetter()
		let viewWithGradient = backgroundGradient.setGradientToView(with: [DarkBlueHue_DEFAULT,LightBlueHue_DEFAULT], size: view.bounds)
		
		view.addSubview(viewWithGradient)
		view.sendSubviewToBack(viewWithGradient)
	}
}


