//
//  ConnectModuleAssembly.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

class ConnectModuleAssembly {
    func assemble() -> UIViewController {
        let viewController = ConnectViewController()
        let presenter = ConnectPresenter()
        let router = ConnectRouter()
        let interactor = ConnectInteractor()
        
        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        router.viewController = viewController
        return viewController
    }
}
