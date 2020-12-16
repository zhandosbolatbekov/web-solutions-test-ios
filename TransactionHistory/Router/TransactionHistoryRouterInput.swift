//
//  TransactionHistoryRouterInput.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 04/08/2020.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

protocol TransactionHistoryRouterInput: AlertShowingRouter {
    associatedtype DataModel
    
    func routeBack()
    func routeToPeriodSelection(periodFilter: DatePeriodFilter,
                                moduleOutput: PeriodSelectionModuleOutput)
    func routeToDetails(dataModel: DataModel)
}
