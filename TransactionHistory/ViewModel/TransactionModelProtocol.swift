//
//  TransactionModelProtocol.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 8/5/20.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

import Foundation

protocol TransactionModelProtocol {
    var date: Date { get }
    var transactionId: Int { get }
}

extension PaymentOperationModel: TransactionModelProtocol { }
