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


