//
//  SignUpNicknameVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class SignUpNicknameVC: UIViewController {

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameTextField.layer.masksToBounds = true
        nicknameTextField.layer.cornerRadius = 22.0
        nicknameTextField.layer.borderWidth = 1.0
        nextButton.layer.cornerRadius = 24.0
        
        nicknameTextField.addLeftPadding()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
}
