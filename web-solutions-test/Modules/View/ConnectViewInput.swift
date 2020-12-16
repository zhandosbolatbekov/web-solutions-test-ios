//
//  ConnectViewInput.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

protocol ConnectViewInput: class {
    func updateConnectButton(state: ConnectButtonViewState)
    func setTimer(text: String?)
}
