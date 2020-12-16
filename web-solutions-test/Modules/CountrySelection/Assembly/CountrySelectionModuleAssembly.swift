//
//  CountrySelectionModuleAssembly.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

typealias CountrySelectionConfiguration = (CountrySelectionModuleInput) -> (CountrySelectionModuleOutput)

class CountrySelectionModuleAssembly {
    func assemble(_ configuration: CountrySelectionConfiguration? = nil) -> UIViewController {
        let viewController = CountrySelectionViewController()
        let presenter = CountrySelectionPresenter()
        let router = CountrySelectionRouter()
        let interactor = CountrySelectionInteractor()
        
        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.moduleOutput = configuration?(presenter)
        interactor.output = presenter
        router.viewController = viewController
        return viewController
    }
}
