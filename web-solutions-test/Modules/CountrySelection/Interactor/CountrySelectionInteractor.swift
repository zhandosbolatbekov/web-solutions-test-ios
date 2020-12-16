//
//  CountrySelectionInteractor.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import Foundation

class CountrySelectionInteractor: CountrySelectionInteractorInput {
    weak var output: CountrySelectionInteractorOutput?
    
    func fetchCountries() {
        output?.didFetch(countries: mockedCountries)
    }
}

private var mockedCountries = [Country(id: 1, name: "Armenia"),
                               Country(id: 2, name: "Azerbaijan"),
                               Country(id: 3, name: "Belarus"),
                               Country(id: 4, name: "Kazakhstan"),
                               Country(id: 5, name: "Kirghizstan"),
                               Country(id: 6, name: "Moldavia"),
                               Country(id: 7, name: "Uzbekistan"),
                               Country(id: 8, name: "Russia"),
                               Country(id: 9, name: "Tajikistan"),
                               Country(id: 10, name: "Turkmenistan")]
