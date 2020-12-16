//
//  TransactionHistoryInteractorInput.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 8/6/20.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

protocol TransactionHistoryInteractorInput {
    func fetchHistory(startDate: String, endDate: String, paymentCode: String?)
}
