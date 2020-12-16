//
//  CountrySelectionRouter.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

class CountrySelectionRouter: CountrySelectionRouterInput {
    weak var viewController: UIViewController?
    
    func routeBack() {
        viewController?.dismiss(animated: true)
    }
}
