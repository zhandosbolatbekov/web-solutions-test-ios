//
//  ConnectButtonViewState.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

enum ConnectButtonViewState {
    case disconnected
    case waiting
    case connected
    
    var statusText: String {
        switch self {
        case .disconnected:
            return "Connect"
        case .waiting:
            return "Wait..."
        case .connected:
            return "Disconnect"
        }
    }
}
