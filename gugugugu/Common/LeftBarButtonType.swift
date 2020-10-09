//
//  LeftBarButtonType.swift
//  gugugugu
//
//  Created by juhee on 2020/10/09.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit


enum LeftBarButtonType {
    case close
    case back
    
    var image: UIImage {
        switch self {
        case .close:
            return UIImage(systemName: "xmark")!
        case .back:
            return UIImage(systemName: "chevron.left")!
        }
    }

}
