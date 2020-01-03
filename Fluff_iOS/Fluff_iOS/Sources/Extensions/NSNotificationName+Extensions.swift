//
//  UINotificationName+Extensions.swift
//  InitialProject
//
//  Created by 윤동민 on 2019/12/20.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation
import UIKit

extension NSNotification.Name {
    static let finishEmailCheck = NSNotification.Name("finishEmailCheck")
    static let finishSignup = NSNotification.Name("finishSignup")
    static let clickApplyButton = NSNotification.Name("clickApplyButton")
    static let selectedDetailCategory = NSNotification.Name("selectedDetailCategory")
    static let panFilterView = NSNotification.Name("panFilterView")
    static let clickFollowButton = NSNotification.Name("clickFollowButton")
    static let clickCartCheckBox = NSNotification.Name("clickCartCheckbox")
    static let autoLoginExcute = NSNotification.Name("autoLoginExcute")
    static let confirmBidding = NSNotification.Name("confirmBidding")
    static let clickCancelButton = NSNotification.Name("clickCancelButton")
    static let clickIntoBannerButton = NSNotification.Name("clickIntoBannerButton")
}
