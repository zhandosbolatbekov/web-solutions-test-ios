//
//  CountrySelectionViewOutput.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

protocol CountrySelectionViewOutput: class {
    func viewIsReady()
    func didSelect(country: Country)
}
