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
    
    
    // MARK: - IBAction
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Property
    
    // MARK: - Method
    private func setUp() {
        addToolBar()
    }
    
    private func addToolBar() {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(doneButtonClicked))
        
        
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBarKeyboard.items = [flexibleButton, doneButton]
        inputTextField.inputAccessoryView = toolBarKeyboard
    }
    
    @objc private func doneButtonClicked() {
        print("Minho")
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
}
