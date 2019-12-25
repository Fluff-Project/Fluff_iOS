//
//  SignUpEmailVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class SignUpEmailVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 22.0
        emailTextField.layer.borderWidth = 1.0
        nextButton.layer.cornerRadius = 24.0
        
        emailTextField.addLeftPadding()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}