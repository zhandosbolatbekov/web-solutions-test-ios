//
//  ConnectRouter.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

class ConnectRouter: ConnectRouterInput {
    weak var viewController: UIViewController?
    
    private let countrySelectionAssembly: CountrySelectionModuleAssembly
    
    init(countrySelectionAssembly: CountrySelectionModuleAssembly) {
        self.countrySelectionAssembly = countrySelectionAssembly
    }
    
    func routeToCountrySelection(currentCountryId: Int?,
                                 moduleOutput: CountrySelectionModuleOutput) {
        let selectionViewController = countrySelectionAssembly.assemble { moduleInput in
            moduleInput.configure(with: CountrySelectionConfigData(selectedCountryId: currentCountryId))
            return moduleOutput
        }
        viewController?.present(selectionViewController, animated: true)
    }
}
