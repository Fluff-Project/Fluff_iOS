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
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var currentView: Int = 0
    var userEmail = String()
    var userPassword = String()
    var userNickname = String()
    var userIsMale: Bool = true
    var gender: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
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
        
        signupProgressBar.transform = signupProgressBar.transform.scaledBy(x: 1, y: 2.5)


        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldEdited(textField: UITextField) {
        
        switch currentView {
            // 이메일 입력 뷰
        case 0:
            if isValidEmail(email: userInfoTextField.text) == true {
                nextButton.isEnabled = true
                errorLabel.text = ""
                nextButton.backgroundColor = UIColor.black
            } else {
                nextButton.isEnabled = false
                errorLabel.text = "이메일 형식에 맞게 입력해 주세요"
                nextButton.backgroundColor = UIColor.disabledGrey
            }
            // 비밀번호 입력 뷰
        case 1:
            if (userInfoTextField.text!.count > 0) {
                nextButton.isEnabled = true
                errorLabel.text = ""
                nextButton.backgroundColor = UIColor.black
            } else {
                nextButton.isEnabled = false
                errorLabel.text = "비밀번호를 입력해 주세요"
                nextButton.backgroundColor = UIColor.disabledGrey
            }
            //닉네임 입력 뷰
        case 2:
            if (0 < userInfoTextField.text!.count) && (userInfoTextField.text!.count < 11) {
                nextButton.isEnabled = true
                errorLabel.text = ""
                nextButton.backgroundColor = UIColor.black
            } else {
                nextButton.isEnabled = false
                errorLabel.text = "10자 이내로 닉네임을 입력해 주세요"
                nextButton.backgroundColor = UIColor.disabledGrey
            }
        default:
            return
        }
    }
    
    func isValidEmail(email: String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    @IBAction func goNext(_ sender: UIButton) {
        
        if signupProgressBar.progress == 1 {
            SignupService.shared.signup(email: userEmail, pwd: userPassword, username: userNickname, gender: gender) { networkResult in
                switch networkResult {
                case .success(let data):
                    guard let signupData = data as? SignupData else { return }
                    guard let userData = signupData.json.data else { return }
                    print(signupData.json)
                    guard let loginVC = self.navigationController?.viewControllers[0] as? LoginVC else { return }
                    loginVC.setUserData(userData)
                    self.navigationController?.popViewController(animated: true)
                    
                case .requestErr(let message):
                    self.presentAlertController(title: "디비 내부 오류 발생", message: "재요청 부탁드립니다.")
                case .serverErr:
                    self.presentAlertController(title: "서버 내부 오류 발생", message: "서버에 문제가 생겼습니다.")
                case .pathErr:
                    print("패스 에러")
                case .networkFail:
                    
                    //
                    guard let loginVC = self.navigationController?.viewControllers[0] as? LoginVC else { return }
                    loginVC.setUserData(SignupUserInform(email: "awd", pwd: "awd", username: "awd", gender: "awd"))
                    self.navigationController?.popViewController(animated: true)
                    NotificationCenter.default.post(name: .autoLoginExcute, object: nil)
                    
                    //나중에 이 로직으로 바꾸기
//                    self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다.")
                }
            }
            return
        }
        
        switch currentView {
            // 이메일 입력 뷰
        case 0:
            userEmail = userInfoTextField.text!
            SignupService.shared.checkDuplicated(email: self.userEmail) { networkResult in
                switch networkResult {
                case .success(let data):
                    guard let duplicatedInform = data as? DuplicatedInform else { return }
                    self.userEmail = duplicatedInform.email
                case .requestErr(let message):
                    guard let duplicatedInform = message as? DuplicatedInform else { return }
                    print("중복된 이메일: \(duplicatedInform.email)")
                    self.presentAlertController(title: "중복되는 ID입니다.", message: nil)
                case .pathErr: print("패스 에러")
                case .serverErr: print("서버 에러")
                case .networkFail: print("네트워크 에러")
                }
            }
            // 비밀번호 입력 뷰
        case 1:
            userPassword = userInfoTextField.text!
            currentView += 1
        case 2:
            userNickname = userInfoTextField.text!
            currentView += 1
        default: return
        }
        
        switch currentView {
            // 이메일 입력 뷰
        case 0:
            userInfoLabel.text = "이메일"
            userInfoTextField.text = ""
            userInfoTextField.placeholder = "이메일을 적어주세요"
            signupProgressBar.setProgress(0.25, animated: true)
            nextButton.isEnabled = false
            errorLabel.text = ""
            nextButton.backgroundColor = UIColor.disabledGrey
            // 비밀번호 입력 뷰
        case 1:
            userInfoLabel.text = "비밀번호"
            userInfoTextField.text = ""
            userInfoTextField.placeholder = "비밀번호를 적어주세요"
            signupProgressBar.setProgress(0.5, animated: true)
            nextButton.isEnabled = false
            errorLabel.text = ""
            nextButton.backgroundColor = UIColor.disabledGrey
            print("여기에 관한건 필요없음")
            //닉네임 입력 뷰
        case 2:
            userInfoLabel.text = "닉네임"
            userInfoTextField.placeholder = "플러프에서 사용할 닉네임을 입력해주세요"
            userInfoTextField.text = ""
            signupProgressBar.setProgress(0.75, animated: true)
            nextButton.isEnabled = false
            errorLabel.text = ""
            nextButton.backgroundColor = UIColor.disabledGrey
            //성별 입력 뷰
        case 3:
            userInfoTextField.isHidden = true
            maleButton.isHidden = false
            femaleButton.isHidden = false
            userInfoLabel.text = "성별을 선택해주세요"
            signupProgressBar.setProgress(1, animated: true)
            nextButton.isEnabled = false
            errorLabel.text = ""
            nextButton.backgroundColor = UIColor.disabledGrey
        default: return
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        
        currentView -= 1
        
        if currentView == -1 {
            self.navigationController?.popViewController(animated: true)
        }
        
        switch currentView {
            // 이메일 입력 뷰
        case 0:
            userInfoLabel.text = "이메일"
            userInfoTextField.placeholder = "이메일을 적어주세요"
            userInfoTextField.text = ""
            signupProgressBar.setProgress(0.25, animated: true)
            nextButton.backgroundColor = UIColor.disabledGrey
            // 비밀번호 입력 뷰
        case 1:
            userInfoLabel.text = "비밀번호"
            userInfoTextField.placeholder = "비밀번호를 적어주세요"
            userInfoTextField.text = ""
            signupProgressBar.setProgress(0.5, animated: true)
            nextButton.backgroundColor = UIColor.disabledGrey
            //닉네임 입력 뷰
        case 2:
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
            //성별 입력 뷰
        case 3:
            userInfoTextField.isHidden = true
            maleButton.isHidden = false
            femaleButton.isHidden = false
            userInfoTextField.text = ""
            userInfoLabel.text = "성별을 선택해주세요"
            signupProgressBar.setProgress(1, animated: true)
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.disabledGrey
        default:
            return
        }
        
    }
    
    
    @IBAction func maleSelected(_ sender: UIButton) {
        femaleButton.layer.borderColor = UIColor.disabledGrey.cgColor
        femaleButton.setTitleColor(UIColor.disabledGrey, for: .normal)
        maleButton.layer.borderColor = UIColor.black.cgColor
        maleButton.setTitleColor(UIColor.black, for: .normal)
        userIsMale = true
        gender = "m"
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
        gender = "f"
        nextButton.setTitle("가입 완료하기", for: .normal)
        nextButton.backgroundColor = UIColor.black
    }
}

extension NewSignUpViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension NewSignUpViewController: UITextFieldDelegate {
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(upKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(downKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(progressSignup), name: .finishEmailCheck, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(successSignup), name: .finishSignup, object: nil)
    }
    
    @objc func upKeyboard() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.nextButton.transform = CGAffineTransform(translationX: 0, y: -200)
            self.signupProgressBar.transform = CGAffineTransform(translationX: 0, y: -200)
        }, completion: nil)
    }
    
    @objc func downKeyboard() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.nextButton.transform = .identity
            self.signupProgressBar.transform = .identity
        }, completion: nil)
    }
    
    @objc func progressSignup() {
        self.currentView += 1
        
        userInfoLabel.text = "비밀번호"
        userInfoTextField.text = ""
        userInfoTextField.placeholder = "비밀번호를 적어주세요"
        signupProgressBar.setProgress(0.5, animated: true)
        nextButton.isEnabled = false
        errorLabel.text = ""
        nextButton.backgroundColor = UIColor.disabledGrey
    }
    
    @objc func successSignup() {
        print("회원가입 성공")
    }
}
