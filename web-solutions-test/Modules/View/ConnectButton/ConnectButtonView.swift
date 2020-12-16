//
//  ConnectButtonView.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

protocol ConnectButtonViewDelegate: class {
    func didTapConnectButtonView()
}

class ConnectButtonView: UIView {
    enum Constants {
        static let size: CGFloat = 140
    }
    
    weak var delegate: ConnectButtonViewDelegate?

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = ConnectButtonViewState.disconnected.statusText
        return label
    }()
    
    private lazy var scaleAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 1.0
        animation.autoreverses = true
        animation.fromValue = 1.0
        animation.toValue = 1.2
        return animation
    }()
    
    init() {
        super.init(frame: .zero)
        markup()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(frame.height, frame.width) / 2.0
    }
    
    func set(state: ConnectButtonViewState) {
        statusLabel.text = state.statusText
        switch state {
        case .disconnected:
            backgroundColor = .white
            setPulse(isAnimating: true)
            statusLabel.textColor = .black
        case .waiting:
            backgroundColor = .lightGray
            statusLabel.textColor = .black
            setPulse(isAnimating: true)
        case .connected:
            backgroundColor = .systemBlue
            statusLabel.textColor = .white
            setPulse(isAnimating: true)
        }
    }
    
    private func markup() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.size),
            widthAnchor.constraint(equalToConstant: Constants.size),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setPulse(isAnimating: Bool) {
        let scaleAnimationKey = "scale"
        if isAnimating {
            layer.add(scaleAnimation, forKey: scaleAnimationKey)
        } else {
            layer.removeAnimation(forKey: scaleAnimationKey)
        }
    }
    
    @objc
    private func didTap() {
        delegate?.didTapConnectButtonView()
    }
}
