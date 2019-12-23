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
        
        emailTextField.delegate = self
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 22.0
        emailTextField.layer.borderWidth = 1.0
        nextButton.layer.cornerRadius = 24
        
    }
    
     func isValidEmail(_emailStr: String) -> Bool {
         do {
             if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: _emailStr, options: [], range: NSRange(location: 0, length: _emailStr.count)) == nil {
                 return false
             }
         } catch {
             return false
         }
         return true
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

extension SignUpEmailVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let email = emailTextField.text else {return}
        if isValidEmail(_emailStr: email) {
            // correct password
            nextButton.alpha = 0.0
            nextButton.isEnabled = true
        } else {
            nextButton.alpha = 0.15
            nextButton.isEnabled = false
        }
    }
}


