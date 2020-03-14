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
	var addQuoteBarButton: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setGradientBackground()
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		setNavigationBarButton()
	}
	
	func setGradientBackground(){
		let backgroundSetter = BackgroundGradientSetter()
		let subView = backgroundSetter.setGradientToView(with: [DarkBlueHue_DEFAULT,LightBlueHue_DEFAULT],size: view.bounds)
		
		view.addSubview(subView)
		view.sendSubviewToBack(subView)
	}
	
	func createAddQuoteBarButton()->UIBarButtonItem{
		UIBarButtonItem(title: "Add Quote", style: .plain, target: self, action: nil)
	}
	
	func setNavigationBarButton(){
		addQuoteBarButton = createAddQuoteBarButton()
		self.navigationController?.navigationBar.topItem?.rightBarButtonItems = [addQuoteBarButton]
	}
}
