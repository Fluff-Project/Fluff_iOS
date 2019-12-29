//
//  ColorCategory.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation
import UIKit

enum ColorCategory: Int {
    case black = 0
    case white = 1
    case gray = 2
    case beige = 3
    case brown = 4
    case hotPink = 5
    case yellow = 6
    case green = 7
    case lightBlue = 8
    case blue = 9
    case check = 10
    case dots = 11
    case purple = 12
    case lightPink = 13
    
    func getBorderColor() -> CGColor {
        switch self {
        case .black: return UIColor.white.cgColor
        case .white: return UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        case .gray: return UIColor.white.cgColor
        case .beige: return UIColor.white.cgColor
        case .brown: return UIColor.white.cgColor
        case .hotPink: return UIColor.white.cgColor
        case .yellow: return UIColor.white.cgColor
        case .green: return UIColor.white.cgColor
        case .lightBlue: return UIColor.white.cgColor
        case .blue: return UIColor.white.cgColor
        case .check: return UIColor.white.cgColor
        case .dots: return UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        case .purple: return UIColor.white.cgColor
        case .lightPink: return UIColor.white.cgColor
        }
    }
}
