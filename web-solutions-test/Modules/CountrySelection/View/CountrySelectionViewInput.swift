//
//  CountrySelectionViewInput.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

protocol CountrySelectionViewInput: class {
    func display(countries: [Country], selectedCountryId: Int?) 
}
