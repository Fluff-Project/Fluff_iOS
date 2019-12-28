//
//  NewSignUpViewController.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/28.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class NewSignUpViewController: UIViewController {

    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var userInfoTextField: UITextField!
    @IBOutlet weak var signupProgressBar: UIProgressView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    var currentView: Int = 0
    var userEmail = String()
    var userPassword = String()
    var userNickname = String()
    var userIsMale: Bool = true
    
    enum ProgressStatus: Int {
        case emailInput = 0
        case pwdInput = 1
        case nicknameInput = 2
        case genderInput = 3
        case complete = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInfoTextField.addLeftPadding()
        userInfoTextField.layer.cornerRadius = 22
        userInfoTextField.layer.borderWidth = 1
        userInfoTextField.layer.masksToBounds = true
        userInfoTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        
        
        nextButton.isEnabled = false
        nextButton.makeCornerRounded(radius: 24)
        
        maleButton.makeCornerRounded(radius: 22)
        maleButton.layer.borderWidth = 1
        maleButton.layer.borderColor = UIColor.disabledGrey.cgColor
        maleButton.isHidden = true
        femaleButton.makeCornerRounded(radius: 22)
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = UIColor.disabledGrey.cgColor
        femaleButton.isHidden = true
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldEdited(textField: UITextField) {
        switch currentView {
        case 0:
            if isValidEmail(email: userInfoTextField.text) == true {
                nextButton.isEnabled = true
                errorLabel.text = ""
                nextButton.backgroundColor = UIColor.black
            } else {
                errorLabel.text = "이메일 형식에 맞게 입력해 주세요"
                nextButton.backgroundColor = UIColor.disabledGrey
            }
            
        case 1:
            if (userInfoTextField.text!.count > 0) {
                nextButton.isEnabled = true
                errorLabel.text = ""
                nextButton.backgroundColor = UIColor.black
            } else {
                errorLabel.text = "비밀번호를 입력해 주세요"
                nextButton.backgroundColor = UIColor.disabledGrey
            }
        case 2:
            if (0 < userInfoTextField.text!.count) && (userInfoTextField.text!.count < 11) {
                nextButton.isEnabled = true
                errorLabel.text = ""
                nextButton.backgroundColor = UIColor.black
            } else {
                errorLabel.text = "10자 이내로 닉네임을 입력해 주세요"
                nextButton.backgroundColor = UIColor.disabledGrey
            }
            
        default:
            break
        }
    }
    
    func isValidEmail(email: String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    @IBAction func goNext(_ sender: UIButton) {
         guard let status = ProgressStatus(rawValue: currentView) else { return }
        
        switch status {
        case .emailInput:
            userEmail = userInfoTextField.text!
        case .pwdInput:
            userPassword = userInfoTextField.text!
        case .nicknameInput:
            userNickname = userInfoTextField.text!
        case .genderInput:
            return
        case .complete:
            return
        }
        
        currentView += 1
        
       
        
        
        switch status {
        case .emailInput:
            userInfoLabel.text = "이메일"
            userInfoTextField.text = ""
            userInfoTextField.placeholder = "이메일을 적어주세요"
            signupProgressBar.setProgress(0.25, animated: true)
            nextButton.isEnabled = false
            errorLabel.text = ""
            nextButton.backgroundColor = UIColor.disabledGrey
        case .pwdInput:
            userInfoLabel.text = "비밀번호"
            userInfoTextField.text = ""
            userInfoTextField.placeholder = "비밀번호를 적어주세요"
            signupProgressBar.setProgress(0.5, animated: true)
            nextButton.isEnabled = false
            errorLabel.text = ""
            nextButton.backgroundColor = UIColor.disabledGrey
        case .nicknameInput:
            userInfoLabel.text = "닉네임"
            userInfoTextField.placeholder = "플러프에서 사용할 닉네임을 입력해주세요"
            userInfoTextField.text = ""
            signupProgressBar.setProgress(0.75, animated: true)
            nextButton.isEnabled = false
            errorLabel.text = ""
            nextButton.backgroundColor = UIColor.disabledGrey
        case .genderInput:
            userInfoTextField.isHidden = true
            maleButton.isHidden = false
            femaleButton.isHidden = false
            userInfoLabel.text = "성별을 선택해주세요"
            signupProgressBar.setProgress(1, animated: true)
            nextButton.isEnabled = false
            errorLabel.text = ""
            nextButton.backgroundColor = UIColor.disabledGrey
        case .complete: return
            
        }
        
    }
    @IBAction func goBack(_ sender: UIButton) {
        guard let status = ProgressStatus(rawValue: currentView) else { return }
        
        currentView -= 1
        
        switch status {
        case .emailInput:
            userInfoLabel.text = "이메일"
            userInfoTextField.placeholder = "이메일을 적어주세요"
            userInfoTextField.text = ""
            signupProgressBar.setProgress(0.25, animated: true)
            nextButton.backgroundColor = UIColor.disabledGrey
        case .pwdInput:
            userInfoLabel.text = "비밀번호"
            userInfoTextField.placeholder = "비밀번호를 적어주세요"
            userInfoTextField.text = ""
            signupProgressBar.setProgress(0.5, animated: true)
            nextButton.backgroundColor = UIColor.disabledGrey
        case .nicknameInput:
            userInfoLabel.text = "닉네임"
            userInfoTextField.placeholder = "플러프에서 사용할 닉네임을 입력해주세요"
            userInfoTextField.text = ""
            signupProgressBar.setProgress(0.75, animated: true)
            maleButton.isHidden = true
            femaleButton.isHidden = true
            userInfoTextField.isHidden = false
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.disabledGrey
            nextButton.setTitle("다음", for: .normal)
        case .genderInput:
            userInfoTextField.isHidden = true
            maleButton.isHidden = false
            femaleButton.isHidden = false
            userInfoTextField.text = ""
            userInfoLabel.text = "성별을 선택해주세요"
            signupProgressBar.setProgress(1, animated: true)
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.disabledGrey
        case .complete:
            return
        }
        
    }
    
    
    @IBAction func maleSelected(_ sender: UIButton) {
        femaleButton.layer.borderColor = UIColor.disabledGrey.cgColor
        femaleButton.setTitleColor(UIColor.disabledGrey, for: .normal)
        maleButton.layer.borderColor = UIColor.black.cgColor
        maleButton.setTitleColor(UIColor.black, for: .normal)
        userIsMale = true
        nextButton.isEnabled = true
        nextButton.setTitle("가입 완료하기", for: .normal)
        nextButton.titleLabel?.text = "가입 완료하기"
        nextButton.backgroundColor = UIColor.black
    }
    
    
    @IBAction func femaleSelected(_ sender: UIButton) {
        maleButton.layer.borderColor = UIColor.disabledGrey.cgColor
        maleButton.setTitleColor(UIColor.disabledGrey, for: .normal)
        femaleButton.layer.borderColor = UIColor.black.cgColor
        femaleButton.setTitleColor(UIColor.black, for: .normal)
        userIsMale = false
        nextButton.isEnabled = true
        nextButton.setTitle("가입 완료하기", for: .normal)
        nextButton.backgroundColor = UIColor.black
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
