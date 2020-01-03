//
//  UILabel+Extensions.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/01.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
  func setSectionFont() {
    self.attributedText = NSMutableAttributedString(string: self.text!, attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 17)!, .foregroundColor: UIColor.black , NSAttributedString.Key.kern: CGFloat(-0.34)])
    }
  func setPropertyFont() {
    self.attributedText = NSMutableAttributedString(string: self.text!, attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 14)!, .foregroundColor: UIColor.black])
    }
 
}
