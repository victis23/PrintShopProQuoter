//
//  UikitWrapper.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

struct UIKitWrapper: UIViewControllerRepresentable {
	
	typealias UIViewControllerType = UINavigationController
	private var company : Company
	private var storyboardPointer : String
	
	func makeUIViewController(context: Context) -> UINavigationController {
		
		let storyboard = UIStoryboard(name: storyboardPointer, bundle: .main)
		
		guard let viewController = storyboard.instantiateInitialViewController() as? AccessControllerProtocol else { fatalError() }
		
		viewController.company = company
		
		return UINavigationController(rootViewController: viewController)
	}
	
	func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
		
	}
	
	init(company: Company, storyboardPointer: String){
		self.company = company
		self.storyboardPointer = storyboardPointer
	}
	
}

protocol AccessControllerProtocol : UIViewController {
	var company : Company! {get set}
}

class OrdersViewController: UIViewController, AccessControllerProtocol {
	
	var company : Company!
	@IBOutlet var companyNameLabel : UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let company = company {
			companyNameLabel.text = company.name
		}
	}
}

class QuotesViewController: UIViewController, AccessControllerProtocol {
	
	var company : Company!
	@IBOutlet var companyNameLabel : UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let company = company {
			companyNameLabel.text = company.name
		}
	}
}

class LocationViewController: UIViewController, AccessControllerProtocol {
	
	var company : Company!
	@IBOutlet var companyNameLabel : UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let company = company {
			companyNameLabel.text = company.name
		}
	}
}

class ContactViewController: UIViewController, AccessControllerProtocol {
	
	var company : Company!
	@IBOutlet var companyNameLabel : UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let company = company {
			companyNameLabel.text = company.name
		}
	}
}
