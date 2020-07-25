//
//  HomeViewController.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/07/25.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var letterWriteButton: UIButton!
    
    @IBAction func letterButtonTouchUpInside(_ sender: UIButton) {
        
        guard let viewController = UIStoryboard(name: "Letter", bundle: nil).instantiateViewController(withIdentifier: "Letter") as? LetterViewController else { return }
         
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
