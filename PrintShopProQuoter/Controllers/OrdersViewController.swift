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
		
		let backgroundGradient = BackgroundGradient()
		let viewWithGradient = backgroundGradient.setGradientToView(with: [DarkBlueHue_DEFAULT,LightBlueHue_DEFAULT], size: view.bounds)
		
		view.addSubview(viewWithGradient)
		view.sendSubviewToBack(viewWithGradient)
	}
}

class BackgroundGradient {
	
	private func createView()-> UIView {
		let view = UIView()
		
		return view
	}
	
	func setGradientToView(with colors: [CGColor], size : CGRect) -> UIView {
		let gradient = CAGradientLayer()
		gradient.type = .axial
		gradient.colors = colors
		gradient.startPoint = CGPoint(x: 1, y: 0)
		gradient.endPoint = CGPoint(x: 1, y: 1)
		let view = createView()
		gradient.frame = size
		view.layer.addSublayer(gradient)
		return view
	}
}
