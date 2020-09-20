//
//  LetterViewController.swift
//  gugugugu
//
//  Created by jeongminho on 2020/07/25.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

class LetterToViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var toAndTitleView: UIView!
    @IBOutlet weak var letterCategoryLabel: UILabel!
    @IBOutlet weak var letterToLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    
    // MARK: - IBAction
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Method
    private func setUp() {
        inputTextField.delegate = self
        addKeyboardObserver()
        addTapGesture(to: self.view)
    }
    
    private func whenToTextFieldIsFilled() {
        inputLabel.text = inputTextField.text
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.inputLabel.frame.origin = CGPoint(x: self.letterToLabel.frame.origin.x, y: self.letterToLabel.frame.origin.y - 80)

            self.letterToLabel.text = self.inputTextField.text
        }, completion: { (_) in
            self.inputLabel.frame.origin = CGPoint(x: self.inputTextField.frame.origin.x, y: self.inputTextField.frame.origin.y)
            self.inputLabel.text = ""
            self.view.endEditing(true)
        })
        inputTextField.text = ""
    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y =  -150
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    private func addTapGesture(to view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboard))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
}

// MARK: - UITextFieldDelegate
extension LetterToViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        whenToTextFieldIsFilled()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let textFieldTextLength = text.count + string.count - range.length
        
        return textFieldTextLength <= 10
    }
}

