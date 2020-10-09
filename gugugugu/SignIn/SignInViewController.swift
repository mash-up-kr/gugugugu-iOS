//
//  SignInViewController.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/10/01.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit
import AuthenticationServices

class SignInViewController: UIViewController {

    @IBOutlet weak var buttonStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

// MARK: - Initialize
private extension SignInViewController {
    func setupView() {
        let appleIDButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn,
                                                         authorizationButtonStyle: .white)
        appleIDButton.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
        buttonStackView.addArrangedSubview(appleIDButton)
    }
}

// MARK: - Actions
extension SignInViewController {
    @objc func actionHandleAppleSignin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()

        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - Pagination
private extension SignInViewController {
    func presentSignUpViewController() {
        let signUpViewController = SignUpViewController.storyboardInstance()
        present(signUpViewController, animated: true, completion: nil)
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension SignInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            if let _ = credentials.email, let _ = credentials.fullName {
                presentSignUpViewController()
//                registerNewAccount(credential: appleIdCredential)
            } else {
//                signInWithExistingAccount(credential: appleIdCredential)
                let id = String(decoding: credentials.identityToken ?? Data(), as: UTF8.self)
                let auth = String(decoding: credentials.authorizationCode ?? Data(), as: UTF8.self)
                presentSignUpViewController()
            }

        default:
            break
        }
     }
}

// MARK: - StoryboardInstanceable
extension SignInViewController: StoryboardInstanceable {
    static var storyboardName: String { "SignIn" }
}
