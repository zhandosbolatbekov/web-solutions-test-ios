//
//  ConnectViewController.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

class ConnectViewController: UIViewController, ConnectViewInput {
    var output: ConnectViewOutput? {
        didSet {
            connectButtonView.delegate = output
        }
    }
    
    private lazy var connectButtonView: ConnectButtonView = {
        let view = ConnectButtonView()
        view.delegate = output
        return view
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markup()
    }
    
    func setTimer(text: String?) {
        timerLabel.text = text
    }
    
    func updateConnectButton(state: ConnectButtonViewState) {
        connectButtonView.set(state: state)
    }
    
    private func markup() {
        view.backgroundColor = .white
        [connectButtonView, timerLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            connectButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectButtonView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerLabel.topAnchor.constraint(equalTo: connectButtonView.bottomAnchor, constant: 24),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
