//
//  TransactionHistoryViewController.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 04/08/2020.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

import UIKit

private enum Constants {
    static let headerFilterViewHeight: CGFloat = 60
    static let tableViewEstimatedRowHeight: CGFloat = 72
}

class TransactionHistoryViewController<CellAdapter: TransactionHistoryCellAdapter>:
    UIViewController,
    TransactionHistoryViewInput
{

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    var output: TransactionHistoryViewOutput?
    var categoriesViewOutput: SelectableItemsCarouselViewOutput? {
        didSet {
            categoriesView.output = categoriesViewOutput
        }
    }
    private lazy var tableViewManager =
        LogoTableViewManager<CellAdapter, TableViewSectionModel<CellAdapter>>(tableView: tableView)
    
    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private lazy var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Asset.iconClose.image,
            style: .plain,
            target: self,
            action: #selector(didTapCloseButton))
        navigationItem.title = "JB_HISTORY".localized()
        bar.setItems([navigationItem], animated: false)
        bar.tintColor = Color.mainNemo
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        return bar
    }()
    private lazy var headerFilterView: FilterByDateView = {
        let view = FilterByDateView()
        view.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapFilterView))
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    private lazy var tableStatusView: TableStatusView = {
        let view = TableStatusView()
        view.compoundShimmeringViews = {
            let view = StackContainerView()
            for i in 0..<10 {
                view.add(view: makeShimmeringFavoritesView())
            }
            return view
        }()
        return view
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeight
        tableView.separatorStyle = .none
        let emptyView = UIView(frame: CGRect.zero)
        emptyView.frame.size.height = CGFloat.leastNormalMagnitude
        tableView.tableHeaderView = emptyView
        tableView.tableFooterView = emptyView
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.estimatedSectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    private lazy var categoriesView: SelectableItemsCarouselView = {
        let view = SelectableItemsCarouselView()
        view.output = categoriesViewOutput
        return view
    }()

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - TransactionHistoryViewInput
    // ------------------------------

    func showLoadingState() {
        tableStatusView.render(for: .loading)
        tableView.isHidden = true
    }
    
    func showFilledOrEmptyState(sectionModels: [TableViewSectionModel<CellAdapter>]) {
        tableViewManager.display(sections: sectionModels)
        tableView.isHidden = false
        tableView.reloadData()
        let state: TableStatusView.State = sectionModels.isEmpty
            ? .empty(statusText: "JB_HISTORY_EMPTY".localized(),
                     image: Asset.luckyMeditating.image)
            : .filled
        tableStatusView.render(for: state)
    }
    
    func showFailureState() {
        tableStatusView.render(for: .failure(retryAction: output?.didTapRetryButton ?? { }))
        tableView.isHidden = true
    }
    
    func setFilterView(title: String) {
        headerFilterView.set(title: title)
    }
    
    func setCategories(viewAdapter: SelectableItemsCarouselViewAdapter) {
        categoriesView.update(with: viewAdapter)
        categoriesView.isHidden = false
        
        tableView.snp.remakeConstraints {
            $0.top.equalTo(categoriesView.snp.bottom).offset(LayoutGuidance.offset)
            $0.left.right.bottom.equalToSuperview()
        }
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        view.backgroundColor = Color.mainWhite
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [navigationBar, headerFilterView, tableView, tableStatusView, categoriesView]
            .forEach(view.addSubview(_:))
        categoriesView.isHidden = true
    }
    private func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        headerFilterView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(Constants.headerFilterViewHeight)
        }
        categoriesView.snp.makeConstraints {
            $0.top.equalTo(headerFilterView.snp.bottom).offset(LayoutGuidance.offsetQuarter)
            $0.left.right.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerFilterView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        tableStatusView.snp.makeConstraints {
            $0.top.equalTo(tableView)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func makeShimmeringFavoritesView() -> UIView {
        let view = UIView()
        let imageView = ShimmeringView(cornerRadius: 15)
        let titleView = ShimmeringView()
        let subtitleView = ShimmeringView()
        [imageView, titleView, subtitleView]
            .forEach(view.addSubview(_:))
        imageView.snp.makeConstraints { (make) in
            make.size.equalTo(40)
            make.top.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        titleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(18)
            make.width.equalTo(73)
            make.height.equalTo(16)
            make.left.equalTo(imageView.snp.right).offset(16)
        }
        subtitleView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.width.equalTo(93)
            make.height.equalTo(12)
            make.left.equalTo(imageView.snp.right).offset(16)
        }
        return view
    }
    
    @objc private func didTapCloseButton() {
        output?.didTapCloseButton()
    }
    
    @objc private func didTapFilterView() {
        output?.didTapFilterView()
    }
}
