//
//  CountrySelectionTableViewManager.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

final class CountrySelectionTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    enum Constants {
        static let countryCellIdentifier = "CountryCellIdentifier"
    }
    
    private weak var tableView: UITableView?
    private var countries: [Country] = []
    private var selectedCountryId: Int?
    
    var onDidSelect: ((Country) -> Void)?
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.countryCellIdentifier)
    }
    
    func display(countries: [Country], selectedCountryId: Int?) {
        self.countries = countries
        self.selectedCountryId = selectedCountryId
        tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < countries.count else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.countryCellIdentifier, for: indexPath)
        cell.selectionStyle = .blue
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        return filled(cell: cell, for: countries[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < countries.count else {
            return
        }
        onDidSelect?(countries[indexPath.row])
    }
    
    private func filled(cell: UITableViewCell, for country: Country) -> UITableViewCell {
        let itemView = CountryItemView()
        let itemViewAdapter = CountryItemViewAdapter(
            iconName: "icon_country_\(country.name)",
            name: country.name,
            isSelected: country.id == selectedCountryId
        )
        itemView.update(with: itemViewAdapter)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(itemView)
        NSLayoutConstraint.activate([
            itemView.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 24),
            itemView.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: -24),
            itemView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 4),
            itemView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -4)
        ])
        return cell
    }
}
