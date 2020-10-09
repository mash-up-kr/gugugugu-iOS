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
    @IBOutlet private weak var inputTextField: UITextField?
    @IBOutlet private weak var inputTextView: UITextView?
    @IBOutlet private weak var toAndTitleView: UIView?
    @IBOutlet private weak var letterCategoryLabel: UILabel?
    @IBOutlet private weak var letterToLabel: UILabel?
    @IBOutlet private weak var letterFromLabel: UILabel?
    @IBOutlet private weak var seperationView: UIView?
    @IBOutlet private weak var inputLabel: UILabel?
    @IBOutlet private weak var sequenceView: UIView?
    @IBOutlet private weak var currentPageLabel: UILabel?
    
    // MARK: - IBAction
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Property
    private var currentCategory: LetterCategory = .to
    
    // MARK: - Method
    private func setUp() {
        setView()
        inputTextView?.delegate = self
        inputTextField?.delegate = self
        addKeyboardObserver()
        addTapGesture(to: self.view)
    }
    
    private func setView() {
        sequenceView?.backgroundColor = UIColor(red: 21, green: 21, blue: 22, alpha: 0)
        
        inputTextView?.isHidden = true
        inputTextView?.textContainerInset = .zero
    }
    
    private func categoryToIsFilled() {
        letterToLabel?.text = inputTextField?.text
        inputLabel?.text = ""
        inputTextField?.text = ""
        
        letterCategoryLabel?.text = "이 편지를 대표할 문장을 입력해주세요."
        inputTextField?.placeholder = "이 편지는"
        currentPageLabel?.text = "2 / 4"
        seperationView?.isHidden = true
        
        view.endEditing(true)
        currentCategory = .from
    }
    
    private func categoryFromIsFilled() {
        letterFromLabel?.text = inputTextField?.text
        inputLabel?.text = ""
        inputTextField?.text = ""
        
        letterCategoryLabel?.text = "편지를 작성해주세요."
        inputTextField?.placeholder = "내가 전달하고 싶은 이야기"
        currentPageLabel?.text = "3 / 4"
        seperationView?.isHidden = false
        inputTextView?.isHidden = false
        
        view.endEditing(true)
        currentCategory = .letter
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
        
        switch currentCategory {
        case .to:
            categoryToIsFilled()
        case .from:
            categoryFromIsFilled()
        case .letter:
            print("Minho")
        case .draw:
            print("Minho")
        }

        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let textFieldTextLength = text.count + string.count - range.length
        
        switch currentCategory {
        case .to, .from:
            return textFieldTextLength <= 10
        default:
            return textFieldTextLength <= 100
        }
    }
}

extension LetterToViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard let textViewText = textView.text else { return true }
        let textViewTextLength = textViewText.count + text.count - range.length
        
        return textViewTextLength <= 200
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let fixedWidth = inputTextView?.frame.size.width else { return }
        let changedSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: max(changedSize.width, fixedWidth), height: changedSize.height)
    }
}

