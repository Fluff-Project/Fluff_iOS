//
//  UIView+Extensions.swift
//  InitialProject
//
//  Created by 윤동민 on 2019/12/20.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation
import UIKit

// UIView Extension 자주 사용하는 기능

extension UIView {
    
    // View 모서리 둥글게
    func makeCornerRounded(radius: CGFloat?) {
        if let radius = radius {
            // 지정한 Radius로 둥글게
            self.layer.cornerRadius = radius
        } else {
            // 지정하지 않은 경우 원
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
    
    // View Shadow 지정
    func makeShadow(opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        
        // 지정한 Shadow 투명도
        self.layer.shadowOpacity = opacity
        // 지정한 Shadow Radius
        self.layer.shadowRadius = radius
    }
    
    // View Border Width 지정
    func setBorderWidth(width: CGFloat) {
        self.layer.borderWidth = width
    }
    
    // View Border Color 지정
    func setBorderColor(color: CGColor) {
        self.layer.borderColor = color
    }
}
