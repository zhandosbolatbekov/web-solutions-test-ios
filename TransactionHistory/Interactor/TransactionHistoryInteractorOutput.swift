//
//  TransactionHistoryInteractorOutput.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 8/6/20.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

protocol TransactionHistoryInteractorOutput: class {
    func proceed(with operationList: [TransactionModelProtocol])
    func showError(_ error: NetworkError)
}
