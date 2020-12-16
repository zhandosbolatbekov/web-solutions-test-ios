//
//  TransactionHistoryViewModel.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 04/08/2020.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

import Foundation

class TransactionHistoryViewModel<
    ViewInput: TransactionHistoryViewInput,
    Mapper: TransactionHistoryMapperProtocol,
    Router: TransactionHistoryRouterInput
    > where
    ViewInput.CellAdapter == Mapper.CellAdapter,
    Router.DataModel == ViewInput.CellAdapter.DataModel
{

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: ViewInput?
    var router: Router?
    var calendar: Calendar?
    var interactor: TransactionHistoryInteractorInput?
    weak var moduleOutput: TransactionHistoryModuleOutput?
    private let mapper: Mapper
    private var sectionModels: [TableViewSectionModel<ViewInput.CellAdapter>] = []
    private lazy var datePeriodFilter = DatePeriodFilter(
        period: .month,
        calendar: calendar ?? .current)
    private var configData: TransactionHistoryConfigData?
    private var paymentCode: String?
    
    // ------------------------------
    // MARK: - Init
    // ------------------------------
    
    init(mapper: Mapper) {
        self.mapper = mapper
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func fetchHistory() {
        view?.showLoadingState()
        let filterInterval = datePeriodFilter.getDateInterval()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GlobalConstants.DateFormat.date
        interactor?.fetchHistory(
            startDate: dateFormatter.string(from: filterInterval.start),
            endDate: dateFormatter.string(from: filterInterval.end),
            paymentCode: paymentCode)
    }
    
    private func didSelectItemAt(_ indexPath: IndexPath) {
        let cellAdapter = sectionModels[indexPath.section].items[indexPath.row]
        router?.routeToDetails(dataModel: cellAdapter.dataModel)
    }
}

extension TransactionHistoryViewModel: TransactionHistoryModuleInput {
    func configure(data: TransactionHistoryConfigData) {
        configData = data
        paymentCode = configData?.paymentCode
    }
}

extension TransactionHistoryViewModel: PeriodSelectionModuleOutput {
    func periodSelectionModuleDidApply(periodFilter: DatePeriodFilter) {
        self.datePeriodFilter = periodFilter
        view?.setFilterView(title: periodFilter.getFormattedDateTitle())
        fetchHistory()
    }
}

extension TransactionHistoryViewModel: TransactionHistoryViewOutput {
    func didLoad() {
        fetchHistory()
        view?.setFilterView(title: datePeriodFilter.getFormattedDateTitle())
        if let categories = configData?.categories {
            view?.setCategories(
                viewAdapter: SelectableItemsCarouselViewAdapter(
                    items: categories.map { $0.title },
                    pickedIndex: 0))
        }
    }
    
    func didTapRetryButton() {
        fetchHistory()
    }
    
    func didTapFilterView() {
        router?.routeToPeriodSelection(
            periodFilter: datePeriodFilter,
            moduleOutput: self)
    }
    
    func didTapCloseButton() {
        router?.routeBack()
    }
}

extension TransactionHistoryViewModel: TransactionHistoryInteractorOutput {
    func proceed(with operationList: [TransactionModelProtocol]) {
        let dataModels = operationList.compactMap { $0 as? Mapper.DataModel }
        sectionModels = mapper.mapToSections(operationList: dataModels)
        sectionModels.forEach { sectionModel in
            sectionModel.onSelection = { [weak self] in
                self?.didSelectItemAt($0)
            }
        }
        view?.showFilledOrEmptyState(sectionModels: sectionModels)
    }
    
    func showError(_ error: NetworkError) {
        router?.showAlert(title: nil, message: error.message)
        view?.showFailureState()
    }
}

extension TransactionHistoryViewModel: SelectableItemsCarouselViewOutput {
    func didSelect(index: Int) {
        paymentCode = configData?.categories?[safe: index]?.code
        fetchHistory()
    }
}
