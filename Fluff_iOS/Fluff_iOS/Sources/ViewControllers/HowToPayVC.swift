//
//  HowToPayViewController.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/31.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class HowToPayVC: UIViewController {

    @IBOutlet var payCompleteButton: UIButton!
    @IBOutlet var accountTransferButton: UIButton!
    @IBOutlet var selectBankTextField: UITextField!
    @IBOutlet var customerNameTextField: UITextField!
    @IBOutlet var howToPayView: UIView!
    @IBOutlet var bankPickerView: UIPickerView!
    @IBOutlet var doneSelectToolbar: UIToolbar!
    
    var buttonClicked: Bool = false
    var whatBank = String()
    var whatName = String()
    
    let bankList: [String] = ["카카오뱅크","국민은행","신한은행","우리은행","하나은행"]
    
    let bankImgList: [UIImage] = [#imageLiteral(resourceName: "kakaobankBar"), #imageLiteral(resourceName: "kbbankBar"), #imageLiteral(resourceName: "shbankBar"), #imageLiteral(resourceName: "wooribankBar"), #imageLiteral(resourceName: "hanabankBar")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whatBank = bankList[0]
        print(whatName)
        setNavi()
        
        howToPayView.isHidden = true
        bankPickerView.isHidden = true
        doneSelectToolbar.isHidden = true
        
        bankPickerView.delegate = self as UIPickerViewDelegate
        
        bankPickerView.dataSource = self as UIPickerViewDataSource
        
        selectBankTextField.addLeftPadding16()
        selectBankTextField.isEnabled = false
        payCompleteButton.makeCornerRounded(radius: 24)
        customerNameTextField.addLeftPadding16()
        customerNameTextField.setBorderColor(color: UIColor(white: 214.0 / 255.0, alpha: 1.0).cgColor)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done = UIBarButtonItem(title: "완료", style: .done, target: nil, action: #selector(onDoneButtonTapped))

        
        doneSelectToolbar.setItems([flexibleSpace, done], animated: false)

        
        done.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)

        

        
        // Do any additional setup after loading the view.
    }
    
    @objc func onDoneButtonTapped() {
        selectBankTextField.text = whatBank
        doneSelectToolbar.isHidden = true
        bankPickerView.isHidden = true
    }
    
    private func setNavi() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "10"), style: .done, target: self, action:
        #selector(popView))
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showBankList(_ sender: UIButton) {
        bankPickerView.isHidden = false
        doneSelectToolbar.isHidden = false
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

    @IBAction func paymentComplete(_ sender: UIButton) {
        whatName = customerNameTextField.text!
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "EndPaymentVC") as? EndPaymentVC else { return }
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HowToPayVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bankList[row]
    }
    
}

extension HowToPayVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        whatBank = bankList[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
