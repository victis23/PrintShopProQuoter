//
//  Fetcher+Protocol.swift
//  PrintShopProQuoter
//
//  Created by Scott Leonard on 3/6/20.
//  Copyright © 2020 DuhMarket. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataFetcherProtocol {
	associatedtype Root
	associatedtype Value
	associatedtype ManagedObject : NSFetchRequestResult
	var keypath : KeyPath<Root,Value> {get set}
	var request : NSFetchRequest<ManagedObject>  {get set}
	
}
