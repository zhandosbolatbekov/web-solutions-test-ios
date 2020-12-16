//
//  CountryItemView.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

import UIKit

class CountryItemView: UIView {
    enum Constants {
        static let iconSize: CGFloat = 30
        static let height: CGFloat = 44
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.iconSize / 2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        markup()
    }
    
    required init?(coder: NSCoder) { nil }
    
    func update(with adapter: CountryItemViewAdapter) {
        nameLabel.text = adapter.name
        iconImageView.image = adapter.iconName.flatMap { UIImage(named: $0.lowercased()) }
        backgroundColor = adapter.isSelected
            ? UIColor.systemBlue.withAlphaComponent(0.2)
            : .clear
    }
    
    private func markup() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        clipsToBounds = true
        backgroundColor = .clear
        [iconImageView, nameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -16)
        ])
    }
}
