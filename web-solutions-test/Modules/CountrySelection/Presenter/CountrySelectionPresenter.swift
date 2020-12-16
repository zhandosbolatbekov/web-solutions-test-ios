//
//  CountrySelectionPresenter.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import Foundation

class CountrySelectionPresenter: CountrySelectionViewOutput, CountrySelectionInteractorOutput {
    weak var view: CountrySelectionViewInput?
    var interactor: CountrySelectionInteractorInput?
    var router: CountrySelectionRouterInput?
    weak var moduleOutput: CountrySelectionModuleOutput?
    private var configData: CountrySelectionConfigData?
    
    func viewIsReady() {
        interactor?.fetchCountries()
    }
    
    func didSelect(country: Country) {
        moduleOutput?.didSelect(country: country)
        router?.routeBack()
    }
    
    func didFetch(countries: [Country]) {
        view?.display(countries: countries, selectedCountryId: configData?.selectedCountryId)
    }
}

extension CountrySelectionPresenter: CountrySelectionModuleInput {
    func configure(with data: CountrySelectionConfigData) {
        configData = data
    }
}
