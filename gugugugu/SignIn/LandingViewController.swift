//
//  LandingViewController.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/10/09.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

final class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if UserManager.shared.userID == nil {
            view.window?.changeRootViewController(to: SignInViewController.storyboardInstance())
        } else {
            view.window?.changeRootViewController(to: HomeViewController.storyboardInstance())
        }
    }
}
