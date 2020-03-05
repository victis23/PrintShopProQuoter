//
//  CompanyDeleter+ErrorHandler.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/4/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import Foundation

enum CoreDataDeleterError : Error {
	case valueNotFound
}

extension CoreDataDeleterError : LocalizedError {
	
	var errorDescription: String? {
		switch self {
		case .valueNotFound:
			return NSLocalizedString("A value could not be found for this object!", comment: "No value found...Incorrect or non-existant Index.")
		}
	}
}
