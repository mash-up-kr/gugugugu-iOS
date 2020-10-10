//
//  LetterBoxHeaderView.swift
//  gugugugu
//
//  Created by juhee on 2020/10/10.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit


final class LetterBoxHeaderView: UIView {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var titleLabelBottom: NSLayoutConstraint!
    
    func updateLayout(with offset: CGPoint) {
        self.userLabel.isHidden = self.frame.size.height <= 91
        if self.frame.size.height <= 91 {
            titleLabelBottom.isActive = false
        } else {
            titleLabelBottom.isActive = true
            titleLabelBottom.constant -= offset.y
        }
    }
    
    
    
}
