//
//  UIViewController+Extensions.swift
//  InitialProject
//
//  Created by 윤동민 on 2019/12/20.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation
import UIKit

// UIViewController Extension 자주 사용하는 기능

extension UIViewController {
    
    // NavigationBar 투명하게 설정
    func setNavigationBarClear() {
        guard let bar = self.navigationController?.navigationBar else { return }
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
}
