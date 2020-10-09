//
//  LetterTheme.swift
//  gugugugu
//
//  Created by juhee on 2020/10/09.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit


enum LetterTheme: CaseIterable {
    case cloud
    case green
    case orange
    case sea
    
    var image: UIImage {
        switch self {
        case .cloud:
            return UIImage(named: "letter_bg_cloud")!
        case .green:
            return UIImage(named: "letter_bg_green")!
        case .orange:
            return UIImage(named: "letter_bg_orange")!
        case .sea:
            return UIImage(named: "letter_bg_sea")!
        }
    }
    
    var color: UIColor {
        switch self {
        case .cloud:
            return UIColor(red: 1, green: 146/255, blue: 198/255, alpha: 1)
        case .green:
            return UIColor(red: 87/255, green: 204/255, blue: 140/255, alpha: 1)
        case .orange:
            return UIColor(red: 253/255, green: 114/255, blue: 35/255, alpha: 1)
        case .sea:
            return UIColor(red: 44/255, green: 128/255, blue: 1, alpha: 1)
        }
    }
    
    var imageView: UIImageView {
        let imageView = UIImageView(image: self.image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    
    static let themes: [LetterTheme] = LetterTheme.allCases.shuffled()
    
}
