//
//  TransactionHistoryModuleInput.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 04/08/2020.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

/// Adapter struct for TransactionHistory initial configuration 
/// through TransactionHistoryModuleInput
struct TransactionHistoryConfigData {
    var paymentCode: String?
    var categories: [TransactionCategoryAdapter]?
}

struct TransactionCategoryAdapter {
    var title: String
    var code: String?
}

/// Protocol with public methods to configure TransactionHistory 
/// from its parent module (usually implemented by this module's ViewModel)
protocol TransactionHistoryModuleInput: class {
	/// public configuration method for parent modules (add configurating parameters)
    func configure(data: TransactionHistoryConfigData)
}
