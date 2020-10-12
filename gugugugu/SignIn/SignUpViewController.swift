//
//  SignUpViewController.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/10/03.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

final class SignUpViewController: UIViewController {

    @IBOutlet weak var navigationView: BaseNavigationView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpButtonBottomConstraint: NSLayoutConstraint!

    private var api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let closeButton = UIButton(type: .custom)
        // TODO: Replace Zeplin Image After Adding Image
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.addTarget(self, action: #selector(actionCloseButton(sender:)), for: .touchUpInside)
        navigationView.addRightBar(button: closeButton)

        setupNotification()
    }
}

// MARK - Notification
private extension SignUpViewController {
    func setupNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.handleUIKeyboardWillShow(sender:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.handleUIKeyboardWillHide(sender:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc func handleUIKeyboardWillShow(sender: Notification) {
        guard
            let endFrameValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let animationDuration = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
            let animationCurveRawValue = sender.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        else {
            return
        }
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRawValue.uintValue)
        signUpButtonBottomConstraint.constant = endFrameValue.cgRectValue.height - view.safeAreaInsets.bottom

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: animationDuration.doubleValue,
                                                       delay: 0,
                                                       options: animationCurve,
                                                       animations: { self.view.layoutIfNeeded() },
                                                       completion: nil)
    }

    @objc func handleUIKeyboardWillHide(sender: Notification) {
        guard
            let animationDuration = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
            let animationCurveRawValue = sender.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        else {
            return
        }
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRawValue.uintValue)
        signUpButtonBottomConstraint.constant = 0

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: animationDuration.doubleValue,
                                                       delay: 0,
                                                       options: animationCurve,
                                                       animations: { self.view.layoutIfNeeded() },
                                                       completion: nil)
    }
}

// MARK: - Actions
private extension SignUpViewController {
    @objc func actionCloseButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func actionSignUpButton(_ sender: UIButton) {
        api.request(.signUp(tokenID: "", name: "", nickname: "", email: ""))
            .map(to: User.self)
            .then { user in
                UserManager.shared.update(user)
            }.then {
                self.view.window?.changeRootViewController(to: HomeViewController.storyboardInstance())
            }
    }
}

// MARK: - StoryboardInstanceable
extension SignUpViewController: StoryboardInstanceable {
    static var storyboardName: String { "SignUp" }
}
