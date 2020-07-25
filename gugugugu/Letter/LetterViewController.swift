//
//  LetterViewController.swift
//  gugugugu
//
//  Created by jeongminho on 2020/07/25.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

class LetterViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var toAndTitleView: UIView!
    @IBOutlet weak var letterCategoryLabel: UILabel!
    @IBOutlet weak var letterToLabel: UILabel!
    @IBOutlet weak var letterTitleLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var letterTextView: UITextView!
    
    // MARK: - IBAction
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Property
    
    // MARK: - Method
    private func setUp() {
        inputTextField.delegate = self
        letterTextView.delegate = self
        letterTextView.isHidden = true
    }
    
    private func whenToTextFieldIsFilled() {
        inputLabel.text = inputTextField.text
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.inputLabel.frame.origin = CGPoint(x: self.letterToLabel.frame.origin.x, y: self.letterToLabel.frame.origin.y - 80)

            self.letterToLabel.text = self.inputTextField.text
        }, completion: { (_) in
            self.inputLabel.frame.origin = CGPoint(x: self.inputTextField.frame.origin.x, y: self.inputTextField.frame.origin.y)
            self.inputLabel.text = ""
            self.inputTextField.placeholder = "Title"
            self.letterCategoryLabel.text = "Title"
        })
        inputTextField.text = ""
    }
    
    private func whenTitleTextFieldIsFilled() {
        inputLabel.text = inputTextField.text
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.inputLabel.frame.origin = CGPoint(x: self.letterTitleLabel.frame.origin.x, y: self.letterTitleLabel.frame.origin.y - 80)

            self.letterTitleLabel.text = self.inputTextField.text
        }) { (_) in
            self.inputLabel.frame.origin = CGPoint(x: self.inputTextField.frame.origin.x, y: self.inputTextField.frame.origin.y)
            self.inputLabel.text = ""
            self.inputTextField.placeholder = "Letter"
            self.letterCategoryLabel.text = "Letter"
            self.inputTextField.isHidden = true
            self.inputLabel.isHidden = true
            self.letterTextView.isHidden = false
        }
        inputTextField.text = ""
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
}

// MARK: - UITextFieldDelegate
extension LetterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if inputTextField.placeholder == "To" {
            whenToTextFieldIsFilled()
        } else if inputTextField.placeholder == "Title"{
            whenTitleTextFieldIsFilled()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let textFieldTextLength = text.count + string.count - range.length
        
        if textField.placeholder == "To" || textField.placeholder == "Title" {
            return textFieldTextLength <= 10
        } else {
            return textFieldTextLength <= 1000
        }
    }
}

// MARK: - UITextViewDelegate
extension LetterViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let text = textView.text else { return true }
        let textViewTextLength = text.count + text.count - range.length
        return textViewTextLength <= 500
    }
}
