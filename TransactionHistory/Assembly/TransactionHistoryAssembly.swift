//
//  TransactionHistoryAssembly.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 04/08/2020.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

import UIKit

typealias TransactionHistoryConfiguration = (TransactionHistoryModuleInput) -> TransactionHistoryModuleOutput?

class TransactionHistoryModuleAssembly: BaseModuleAssembly {
    typealias GenericViewController = TransactionHistoryViewController<PaymentHistoryCellAdapter>
    typealias Mapper = TransactionHistoryMapper<PaymentOperationModel, PaymentHistoryCellAdapter>
    typealias Router = TransactionHistoryRouter<PaymentOperationModel>
    /// Assembles Module components and returns a target controller
    ///
    /// - Parameter configuration: optional configuration closure called by module owner
    /// - Returns: Assembled module's ViewController
    func assemble(_ configuration: TransactionHistoryConfiguration? = nil) -> UIViewController {
        let viewController = GenericViewController()
        let router = Router(
            periodSelectionModuleAssembly: injection.inject(PeriodSelectionModuleAssembly.self),
            detailsModuleAssembly: injection.inject(StatementDetailsModuleAssembly.self),
            paymentStarter: injection.inject(PaymentFacadeRouting.self))
        let viewModel = TransactionHistoryViewModel<GenericViewController, Mapper, Router>(mapper: Mapper())
        let interactor = TransactionHistoryInteractor(
            paymentService: injection.inject(PaymentServiceProtocol.self))
        router.viewController = viewController
        viewController.output = viewModel
        viewController.categoriesViewOutput = viewModel
        interactor.output = viewModel
        viewModel.view = viewController
        viewModel.router = router
        viewModel.interactor = interactor
        viewModel.calendar = injection.inject(Calendar.self)
        viewModel.moduleOutput = configuration?(viewModel)
        return viewController
    }
}
