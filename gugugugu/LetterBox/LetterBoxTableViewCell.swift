//
//  LetterBoxTableViewCell.swift
//  gugugugu
//
//  Created by juhee on 2020/07/26.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

class LetterBoxTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.containerView.backgroundColor = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContainerView(backgroundColor: UIColor?) {
        self.containerView.backgroundColor = backgroundColor
    }

}
