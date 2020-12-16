//
//  TransactionHistoryRouter.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 04/08/2020.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

import UIKit

class TransactionHistoryRouter<DataModel: TransactionModelProtocol>:
    TransactionHistoryRouterInput,
    StatementDetailsModuleOutput
{
    let alertFactory = AlertFactory()
    weak var viewController: UIViewController?
    private let periodSelectionModuleAssembly: PeriodSelectionModuleAssembly?
    private let detailsModuleAssembly: StatementDetailsModuleAssembly?
    private let paymentStarter: PaymentFacadeRouting?
    
    init(periodSelectionModuleAssembly: PeriodSelectionModuleAssembly?,
         detailsModuleAssembly: StatementDetailsModuleAssembly?,
         paymentStarter: PaymentFacadeRouting?) {
        self.periodSelectionModuleAssembly = periodSelectionModuleAssembly
        self.detailsModuleAssembly = detailsModuleAssembly
        self.paymentStarter = paymentStarter
    }
    
    // ------------------------------
    // MARK: - TransactionHistoryRouterInput
    // ------------------------------
    
    func routeBack() {
        viewController?.dismiss(animated: true)
    }
    
    func routeToPeriodSelection(
        periodFilter: DatePeriodFilter,
        moduleOutput: PeriodSelectionModuleOutput) {
        let configuration: PeriodSelectionConfiguration = { moduleInput in
            let configData = PeriodSelectionConfigData(
                title: "JB_HISTORY_PERIOD_TITLE".localized(),
                periodFilter: periodFilter)
            moduleInput.configure(data: configData)
            return moduleOutput
        }
        guard let controller = periodSelectionModuleAssembly?.assemble(configuration) else {
            return
        }
        viewController?.present(controller, animated: true)
    }
    
    func routeToDetails(dataModel: DataModel) {
        guard let controller = detailsModuleAssembly?.assemble({ moduleInput in
            let configData = StatementDetailsConfigData(transactionDataModel: dataModel)
            moduleInput.configure(data: configData)
            return self
        }) else {
            return
        }
        viewController?.present(controller, animated: true)
    }
    
    // ------------------------------
    // MARK: - StatementDetailsModuleOutput
    // ------------------------------
    
    func didRepeatPayment(with dataModel: PaymentDataModel, checkModel: OnlineCheckModel?) {
        viewController?.presentingViewController?.dismiss(animated: true)
        let starterConfig = PaymentStarterConfiguraton(
            paymentDataModel: dataModel,
            onlineCheckModel: checkModel,
            subscription: nil)
        paymentStarter?.route(starterConfig: starterConfig)
    }
}
