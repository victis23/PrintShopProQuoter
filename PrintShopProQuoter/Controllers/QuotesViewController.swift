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
		
		self.title = "Quotes"
		
		self.navigationController?.navigationBar.titleTextAttributes = [
			NSAttributedString.Key.foregroundColor : UIColor.blue,
			NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)
		]
	}
}
