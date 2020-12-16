//
//  TransactionHistoryCellAdapter.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 8/6/20.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

import UIKit

protocol TransactionHistoryCellAdapter: LogoCellAdapter {
    associatedtype DataModel
    
    init(dataModel: DataModel)
    
    var date: Date { get }
    
    var dataModel: DataModel { get }
}
