//
//  UITextField+Extensions.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
