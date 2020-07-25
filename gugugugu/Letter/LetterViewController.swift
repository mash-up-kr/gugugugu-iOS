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
    
    @IBOutlet weak var toLabel: UILabel!
    
    // MARK: - IBAction
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Property
    
    // MARK: - Method
    private func setUp() {
        inputTextField.delegate = self
    }
    
    private func whenToTextFieldIsFilled() {
        
        toLabel.text = inputTextField.text
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.toLabel.frame.origin = CGPoint(x: self.letterToLabel.frame.origin.x, y: self.letterToLabel.frame.origin.y - 80)
            self.toAndTitleView.sendSubviewToBack(self.toLabel)
        }, completion: nil)
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
        whenToTextFieldIsFilled()
        return true
    }
}
