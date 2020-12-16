//
//  ConnectInteractor.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import Foundation

class ConnectInteractor: ConnectInteractorInput {
    weak var output: ConnectInteractorOutput?
    
    func connectToCountry(with id: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.output?.connectionSucceeded()
        }
    }
    
    func disconnect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.output?.disconnected()
        }
    }
}
