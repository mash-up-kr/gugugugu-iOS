//
//  TitleView.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/07/25.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

final class HomeTitleView: UIView {

    private var userLabel: UILabel!
    private var notificationButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
        setupLayout()
    }

    private func setupView() {
        userLabel = UILabel(frame: .zero)
        userLabel.numberOfLines = 2
        userLabel.font = .systemFont(ofSize: 24)
        addSubview(userLabel)

        notificationButton = UIButton(frame: .zero)
        notificationButton.setImage(UIImage(systemName: "bell"), for: .normal)
        addSubview(notificationButton)
    }

    private func setupLayout() {
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 58)
        ])
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: topAnchor),
            userLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            userLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            notificationButton.topAnchor.constraint(equalTo: topAnchor),
            notificationButton.leadingAnchor.constraint(equalTo: userLabel.trailingAnchor, constant: 8),
            notificationButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            notificationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}

extension HomeTitleView {

    func configure(with user: String) {
        userLabel.text = "안녕하세요,\n\(user)"
    }
}
