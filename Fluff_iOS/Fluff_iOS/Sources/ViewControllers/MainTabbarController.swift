//
//  MainTabbarController.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTabbarColor()
    }
    
    private func setTabbarColor() {
        self.tabBar.barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.94)
        self.tabBar.isTranslucent = false
    }
}