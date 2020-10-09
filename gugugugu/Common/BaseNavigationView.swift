//
//  BaseNavigationView.swift
//  gugugugu
//
//  Created by juhee on 2020/10/09.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit


class BaseNavigationView: UIView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
            titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16.0)
        }
    }
    
    var attributedTitle: NSAttributedString? {
        didSet {
            titleLabel.attributedText = attributedTitle
        }
    }

    var subContentView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            subContentView.map {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
                NSLayoutConstraint.activate([
                    $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                    $0.topAnchor.constraint(equalTo: topAnchor, constant: minimumHeight),
                    $0.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            }
        }
    }
    
    private let minimumHeight: CGFloat = 54.0
    private let leftBarButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let rightBarButtons = UIStackView()
    private lazy var bottomConstraint = {
        bottomAnchor.constraint(equalTo: self.leftBarButton.bottomAnchor)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setLeftBarButton(type: LeftBarButtonType, action selector: Selector) {
        leftBarButton.setImage(type.image, for: .normal)
        leftBarButton.addTarget(nil, action: selector, for: .touchUpInside)
    }
    
    func addRightBarButton(title: String, action selector: Selector) {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: selector, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.0)
        addRightBar(button: button)
    }
    
    func addRightBar(button: UIButton) {
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: .minimumButtonWidth).isActive = true
        rightBarButtons.isHidden = false
        rightBarButtons.addArrangedSubview(button)
    }
    
    
}


private extension BaseNavigationView {
    
    func setupView() {
        tintColor = .white
        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftBarButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        addSubview(titleLabel)
        
        rightBarButtons.translatesAutoresizingMaskIntoConstraints = false
        rightBarButtons.alignment = .fill
        rightBarButtons.axis = .horizontal
        rightBarButtons.distribution = .equalSpacing
        rightBarButtons.spacing = 8.0
        rightBarButtons.isHidden = true
        addSubview(rightBarButtons)
        
        let defaultHeightConstraint = heightAnchor.constraint(equalToConstant: minimumHeight)
        defaultHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            leftBarButton.widthAnchor.constraint(equalToConstant: .minimumButtonWidth),
            leftBarButton.heightAnchor.constraint(equalToConstant: .minimumButtonHeight),
            leftBarButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5.0),
            leftBarButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: leftBarButton.centerYAnchor),
            rightBarButtons.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            rightBarButtons.centerYAnchor.constraint(equalTo: leftBarButton.centerYAnchor),
            rightBarButtons.heightAnchor.constraint(equalToConstant: .minimumButtonHeight),
            defaultHeightConstraint
        ])
    }
    
}
