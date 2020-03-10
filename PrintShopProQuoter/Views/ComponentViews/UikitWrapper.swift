//
//  UikitWrapper.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/1/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import SwiftUI

/// Wraps UIKIT instance in a representable that swiftUI can present.
struct UIKitWrapper: UIViewControllerRepresentable {
	
	//Specify what type of controller is being wrapped in an associated type.
	typealias UIViewControllerType = UIViewController
	
	//Company property passed from parent view. Represents the company the user selected from main view.
	private var company : Company
	
	//Determines which viewcontroller will be presented to user. This string corresponds to the name of the storyboard file in the main bundle.
	private var storyboardPointer : String
	
	init(company: Company?, storyboardPointer: String) {
		
		guard let company = company else {fatalError()}
		
		self.company = company
		self.storyboardPointer = storyboardPointer
	}
	
	func makeUIViewController(context: Context) -> UIViewControllerType {
		
		//Find user defined storyboard in bundle using name.
		let storyboard = UIStoryboard(name: storyboardPointer, bundle: .main)
		
		//Downcast returned controller to protocol AccessControllerProtocol. This step is required because we are not sure which storyboard will be accessed. Potential storyboard controllers that can be called all conform to this protocol. 
		//FIXME: Remove fatalError and create error enum asap.
		guard let viewController = storyboard.instantiateInitialViewController() as? AccessControllerProtocol else { fatalError() }
		
		//Assign user selected company object to instance property on incoming viewController.
		viewController.company = company
		
		//Return UINavigationController with storyboard instance view controller as root controller.
		return viewController
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		
	}
}


