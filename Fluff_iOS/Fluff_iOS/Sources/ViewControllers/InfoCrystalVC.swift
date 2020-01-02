//
//  InfoCrystalVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/01.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import UIKit

class InfoCrystalVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var address3TextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwdConfirmTextField: UITextField!
    
    @IBOutlet weak var findAddressButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var completeButtonView: UIView!
    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var basicCrystalLabel: UILabel!
    @IBOutlet weak var pwdChangeLabel: UILabel!
    @IBOutlet weak var genderSelectLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var newPwdLabel: UILabel!
    @IBOutlet weak var pwdConfirmLabel: UILabel!
    
    var userIsMale: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        idTextField.borderToGrey()
        nicknameTextField.borderToGrey()
        address1TextField.borderToGrey()
        address2TextField.borderToGrey()
        address3TextField.borderToGrey()
        contactTextField.borderToGrey()
        pwdTextField.borderToGrey()
        pwdConfirmTextField.borderToGrey()
        idTextField.addLeftPadding16()
        nicknameTextField.addLeftPadding16()
        address1TextField.addLeftPadding16()
        address2TextField.addLeftPadding16()
        address3TextField.addLeftPadding16()
        contactTextField.addLeftPadding16()
        pwdTextField.addLeftPadding16()
        pwdConfirmTextField.addLeftPadding16()
        basicCrystalLabel.setSectionFont()
        pwdChangeLabel.setSectionFont()
        genderSelectLabel.setSectionFont()
        idLabel.setPropertyFont()
        nicknameLabel.setPropertyFont()
        addressLabel.setPropertyFont()
        contactLabel.setPropertyFont()
        newPwdLabel.setPropertyFont()
        pwdConfirmLabel.setPropertyFont()
        
        maleButton.makeCornerRounded(radius: 22)
        maleButton.layer.borderWidth = 1
        maleButton.layer.borderColor = UIColor.disabledGrey.cgColor
        femaleButton.makeCornerRounded(radius: 22)
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = UIColor.disabledGrey.cgColor
        
        completeButton.makeCornerRounded(radius: 24)
        findAddressButton.makeCornerRounded(radius: 2)
        completeButtonView.layer.borderColor = UIColor(white: 221 / 255, alpha: 1).cgColor
        completeButtonView.layer.borderWidth = 1

        // Do any additional setup after loading the view.
    }
    
    @IBAction func maleSelected(_ sender: UIButton) {
        femaleButton.layer.borderColor = UIColor.disabledGrey.cgColor
        femaleButton.setTitleColor(UIColor.disabledGrey, for: .normal)
        maleButton.layer.borderColor = UIColor.black.cgColor
        maleButton.setTitleColor(UIColor.black, for: .normal)
        userIsMale = true
    }
    
    @IBAction func femaleSelected(_ sender: UIButton) {
        maleButton.layer.borderColor = UIColor.disabledGrey.cgColor
        maleButton.setTitleColor(UIColor.disabledGrey, for: .normal)
        femaleButton.layer.borderColor = UIColor.black.cgColor
        femaleButton.setTitleColor(UIColor.black, for: .normal)
        userIsMale = false
    }
    
    private func setNavi() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "10"), style: .done, target: self, action:
        #selector(popView))
        self.navigationItem.title = "내 정보 수정"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension InfoCrystalVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
