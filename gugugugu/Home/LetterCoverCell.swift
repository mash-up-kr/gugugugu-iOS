//
//  LetterCoverCell.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/07/25.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

final class LetterCoverCell: UICollectionViewCell {

    private var dateLabel: UILabel!
    private var fromLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        dateLabel = UILabel(frame: .zero)
        addSubview(dateLabel)

        fromLabel = UILabel(frame: .zero)
        addSubview(fromLabel)
    }

    private func setupLayout() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 22),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -22),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22)
        ])
        NSLayoutConstraint.activate([
            fromLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            fromLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            fromLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            fromLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24)
        ])
    }
}

extension LetterCoverCell {

    func configure(date: Date, andFromUser from: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateLabel.text = dateFormatter.string(from: date)
        fromLabel.text = "\(from)가\n보낸 편지"
    }
}
