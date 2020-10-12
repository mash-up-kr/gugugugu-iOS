//
//  StoryboardIdentifiable.swift
//  gugugugu
//
//  Created by jeongminho on 2020/10/10.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var identifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension StoryboardIdentifiable where Self: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension StoryboardIdentifiable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension StoryboardIdentifiable where Self: UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
extension UITableViewCell: StoryboardIdentifiable { }
extension UICollectionReusableView: StoryboardIdentifiable { }

