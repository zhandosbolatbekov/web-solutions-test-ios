//
//  CountrySelectionViewController.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

class CountrySelectionViewController: UIViewController, CountrySelectionViewInput {    
    var output: CountrySelectionViewOutput?
    private lazy var countriesTableViewManager: CountrySelectionTableViewManager = {
        let manager = CountrySelectionTableViewManager(tableView: countriesTableView)
        manager.onDidSelect = { [weak self] in
            self?.output?.didSelect(country: $0)
        }
        return manager
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Selection location"
        return label
    }()
    
    private lazy var countriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 40
        tableView.separatorStyle = .none
        let emptyView = UIView(frame: CGRect.zero)
        tableView.tableHeaderView = emptyView
        tableView.tableFooterView = emptyView
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markup()
        output?.viewIsReady()
    }
    
    func display(countries: [Country], selectedCountryId: Int?) { 
        countriesTableViewManager.display(countries: countries, selectedCountryId: selectedCountryId)
    }
    
    private func markup() {
        view.backgroundColor = .white
        [headerLabel, countriesTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countriesTableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            countriesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            countriesTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            countriesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
