//
//  AppDelegate.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        presentInitialScreen()
        return true
    }
    
    private func presentInitialScreen() {
        window?.rootViewController = ConnectModuleAssembly().assemble()
    }
}

