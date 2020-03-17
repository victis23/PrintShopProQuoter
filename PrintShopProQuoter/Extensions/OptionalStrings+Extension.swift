//
//  OptionalStrings+Extension.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/16/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import Foundation

/// Adds additional functionality to Optionals where the wrapped value is of type `String`.
extension Optional where Wrapped == String {
	
	// If string is nil an empty array of characters is added to wrappedValue (this should never occur in practice).
	var wrappedValue: String {
		get {
			return self ?? " "
		}
	}
	
	// Checks to make sure email variable contains "@" and "."
	var isValidEmail : Bool {
		print(wrappedValue)
		return wrappedValue.contains("@") && wrappedValue.contains(".")
	}
	
	// Checks to make sure two strings match.
	func stringsMatch(compare secondValue : String?) -> Bool {
		guard let secondValue = secondValue else {return false}
		return wrappedValue == secondValue
	}
}

/// Adds additional functionality for validating emails.
extension String {
	
	var isValidEmail : Bool {
		self.contains("@") && self.contains(".")
	}
}
