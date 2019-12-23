//
//  ViewController.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/23.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {
    
    @IBOutlet weak var kakaoStartButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 24
        kakaoStartButton.layer.cornerRadius = 24
        // Do any additional setup after loading the view.
    }


}

