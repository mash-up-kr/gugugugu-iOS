//
//  UIKit+Extensions.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/10/09.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

// MARK: - Storyboard Instance
protocol StoryboardInstanceable {
    static var storyboardName: String { get }
}

extension StoryboardInstanceable where Self: UIViewController {
    static func storyboardInstance() -> Self {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as! Self
    }
}

extension UIWindow {
    func changeRootViewController(to newRootViewController: UIViewController) {
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.35
        layer.add(transition, forKey: kCATransition)
        rootViewController = newRootViewController
        makeKeyAndVisible()
    }
}
