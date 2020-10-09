//
//  TransparentSegmentControl.swift
//  gugugugu
//
//  Created by juhee on 2020/10/09.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

protocol TransparentSegmentControlDelegate: class {
    
    func didSelectedControlChange(index: Int)
    
}

@IBDesignable
final class TransparentSegmentControl: UIStackView {
    
    weak var delegate: TransparentSegmentControlDelegate?

    var selectedSegmentIndex: Int = -1 {
        didSet {
            self.didTapped(button: self.buttons[self.selectedSegmentIndex])
        }
    }
    
    private var buttons: [UIButton] = []
    
    init(items: [String]) {
        super.init(frame: .zero)
        
        self.setup()
        
        items.forEach {
            let button = UIButton()
            button.setTitle($0, for: .normal)
            self.setup(button: button)
            self.addArrangedSubview(button)
        }
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.arrangedSubviews
            .compactMap { $0 as? UIButton }
            .forEach { self.setup(button: $0) }
    }
    
    
}

private extension TransparentSegmentControl {

    @objc func didTapped(button: UIButton) {
        self.buttons.forEach {
            if $0 === button {
                $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
                $0.isSelected = true
                self.delegate?.didSelectedControlChange(index: $0.tag)
            } else {
                $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
                $0.isSelected = false
            }
        }
    }
    
    func setup() {
        self.axis = .horizontal
        self.distribution = .fillProportionally
        self.alignment = .center
        self.spacing = 15.0
    }
    
    func setup(button: UIButton) {
        button.tag = self.arrangedSubviews.count
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(.white, for: .highlighted)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = UIColor(named: "darkGrey")
        button.addTarget(nil, action: #selector(didTapped(button:)), for: .touchUpInside)
        self.buttons.append(button)
        self.selectedSegmentIndex = 0
    }

}
