//
//  UIColor+Extensions.swift
//  InitialProject
//
//  Created by 윤동민 on 2019/12/20.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation
import UIKit

// 다자이너 Zepplin 색상 가이드 Extension

extension UIColor {
    
    // fluff 검은 색상
    @nonobjc class var black: UIColor {
      return UIColor(white: 23.0 / 255.0, alpha: 1.0)
    }

    // fluff 화이트 색상
    @nonobjc class var fluffWhite: UIColor {
      return UIColor(white: 248.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var white: UIColor {
      return UIColor(white: 1.0, alpha: 1.0)
    }

    // greyishBrown 색상
    @nonobjc class var greyishBrown: UIColor {
      return UIColor(white: 64.0 / 255.0, alpha: 1.0)
    }

    // disableGrey 색상
    @nonobjc class var disabledGrey: UIColor {
      return UIColor(white: 219.0 / 255.0, alpha: 1.0)
    }
    
    // borderGrey 색상
    @nonobjc class var borderGrey: UIColor {
      return UIColor(white: 232.0 / 255.0, alpha: 1.0)
    }

}
