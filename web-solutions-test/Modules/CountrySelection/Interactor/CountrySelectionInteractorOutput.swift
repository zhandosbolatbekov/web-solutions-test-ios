//
//  CountrySelectionInteractorOutput.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

protocol CountrySelectionInteractorOutput: class {
    func didFetch(countries: [Country])
}
