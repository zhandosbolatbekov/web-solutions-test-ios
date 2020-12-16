//
//  TransactionHistoryViewProtocols.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 04/08/2020.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

protocol TransactionHistoryViewInput: class {
    associatedtype CellAdapter where CellAdapter: TransactionHistoryCellAdapter
    func showLoadingState()
    func showFilledOrEmptyState(sectionModels: [TableViewSectionModel<CellAdapter>])
    func showFailureState()
    func setFilterView(title: String)
    func setCategories(viewAdapter: SelectableItemsCarouselViewAdapter)
}

protocol TransactionHistoryViewOutput {
    func didLoad()
    func didTapRetryButton()
    func didTapCloseButton()
    func didTapFilterView()
}
