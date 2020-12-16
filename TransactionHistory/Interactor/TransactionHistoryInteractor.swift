//
//  TransactionHistoryInteractor.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 8/5/20.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

class TransactionHistoryInteractor: TransactionHistoryInteractorInput {
    weak var output: TransactionHistoryInteractorOutput?
    private let paymentService: PaymentServiceProtocol?
    
    init(paymentService: PaymentServiceProtocol?) {
        self.paymentService = paymentService
    }
    
    func fetchHistory(startDate: String, endDate: String, paymentCode: String?) {
        paymentService?.getPaymentHistory(
            startDate: startDate,
            endDate: endDate,
            paymentCode: paymentCode,
            success: { [weak self] (operationModels) in
                self?.output?.proceed(with: operationModels.filter {
                    $0.channel == GlobalConstants.API.channel
                })
            },
            failure: { [weak self] error in
                self?.output?.showError(error)
        })
    }
}
