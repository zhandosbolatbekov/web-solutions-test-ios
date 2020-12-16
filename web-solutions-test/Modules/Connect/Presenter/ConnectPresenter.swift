//
//  ConnectPresenter.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import Foundation

class ConnectPresenter: ConnectViewOutput, ConnectInteractorOutput {
    weak var view: ConnectViewInput?
    var router: ConnectRouterInput?
    var interactor: ConnectInteractorInput?
    
    private lazy var connectButtonState: ConnectButtonViewState = .disconnected {
        didSet {
            view?.updateConnectButton(state: connectButtonState)
        }
    }
    
    private var connectionTimer: Timer?
    private lazy var connectionTimerCounter: Int = 0
    
    private var currentCountry: Country?
    
    func connectionSucceeded() {
        connectButtonState = .connected
        startConnectionTimer()
    }
    
    func disconnected() {
        connectButtonState = .disconnected
        stopConnectionTimer()
    }
    
    func didTapConnectButtonView() {
        switch connectButtonState {
        case .waiting:
            return
        case .disconnected:
            interactor?.connectToCountry(with: 0)
        case .connected:
            interactor?.disconnect()
        }
        connectButtonState = .waiting
    }
    
    func didTapCountryView() {
        router?.routeToCountrySelection(currentCountryId: currentCountry?.id, moduleOutput: self)
    }
    
    private func startConnectionTimer() {
        connectionTimerCounter = 0
        view?.setTimer(text: Self.getTimerText(for: connectionTimerCounter))
        connectionTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateConnectionTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func stopConnectionTimer() {
        connectionTimer?.invalidate()
        view?.setTimer(text: nil)
    }
    
    @objc
    private func updateConnectionTimer() {
        connectionTimerCounter += 1
        view?.setTimer(text: Self.getTimerText(for: connectionTimerCounter))
    }
    
    private static func getTimerText(for seconds: Int) -> String {
        let minutes = seconds / 60
        let secondsReminder = seconds % 60
        return String(format: "%02i:%02i", minutes, secondsReminder)
    }
}

extension ConnectPresenter: CountrySelectionModuleOutput {
    func didSelect(country: Country) {
        currentCountry = country
        view?.setCountryView(adapter: .init(country: country, isSelected: false))
        interactor?.connectToCountry(with: country.id)
        connectButtonState = .waiting
    }
}
