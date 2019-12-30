//
//  HowToPayViewController.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/31.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class HowToPayViewController: UIViewController {

    @IBOutlet var payCompleteButton: UIButton!
    @IBOutlet var accountTransferButton: UIButton!
    @IBOutlet var selectBankTextField: UITextField!
    @IBOutlet var customerNameTextField: UITextField!
    @IBOutlet var howToPayView: UIView!
    var bankPickerView: UIPickerView!
    var doneSelectToolbar: UIToolbar!
    
    var buttonClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        howToPayView.isHidden = true
        
        selectBankTextField.addLeftPadding16()
        selectBankTextField.isEnabled = false
        payCompleteButton.makeCornerRounded(radius: 24)
        customerNameTextField.addLeftPadding16()
        customerNameTextField.setBorderColor(color: UIColor(white: 214.0 / 255.0, alpha: 1.0).cgColor)
        // Do any additional setup after loading the view.
    }
    
    @objc func onDoneButtonTapped() {
        doneSelectToolbar.removeFromSuperview()
        bankPickerView.removeFromSuperview()
    }
    
    @IBAction func showBankList(_ sender: UIButton) {
        bankPickerView = UIPickerView.init()
        bankPickerView.delegate = self as? UIPickerViewDelegate
        bankPickerView.backgroundColor = UIColor.white
        bankPickerView.setValue(UIColor.black, forKey: "textColor")
        bankPickerView.autoresizingMask = .flexibleWidth
        bankPickerView.contentMode = .center
        bankPickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(bankPickerView)

        doneSelectToolbar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        doneSelectToolbar.isTranslucent = true
        doneSelectToolbar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(doneSelectToolbar)
    }
    
    
    

    @IBAction func transferOrNot(_ sender: UIButton) {
        if buttonClicked == true {
            buttonClicked = false
            accountTransferButton.setBackgroundImage(#imageLiteral(resourceName: "21"), for: .normal)
            howToPayView.isHidden = true
            
        } else {
            buttonClicked = true
            accountTransferButton.setBackgroundImage(#imageLiteral(resourceName: "selectIc"), for: .normal)
            howToPayView.isHidden = false
        }
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
