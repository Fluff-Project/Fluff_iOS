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
        self.delegate = self
    }
    
    private func setTabbarColor() {
        self.tabBar.barTintColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
        self.tabBar.isTranslucent = false
    }
}

extension MainTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
