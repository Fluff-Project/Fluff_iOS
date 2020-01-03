//
//  LikeTabbarController.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/26.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LikeTabbarController: ButtonBarPagerTabStripViewController {

    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        guard let likeListTabVC = self.storyboard?.instantiateViewController(identifier: "LikeListTabVC") as? LikeListTabVC else { return [] }
        
        guard let followingListVC = self.storyboard?.instantiateViewController(identifier: "FollowingListVC") as? FollowingListVC else { return [] }
        return [likeListTabVC, followingListVC]
    }
    
    override func viewDidLoad() {
        self.settings.style.selectedBarHeight = 4
        self.settings.style.buttonBarItemBackgroundColor = UIColor.fluffWhite
        self.settings.style.buttonBarBackgroundColor = UIColor.fluffWhite
        self.settings.style.buttonBarHeight = 44
        self.settings.style.buttonBarMinimumLineSpacing = 59
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarItemLeftRightMargin = 0
        self.settings.style.buttonBarLeftContentInset = 16
        self.settings.style.buttonBarRightContentInset = 16
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.backgroundColor = UIColor.fluffWhite
        
    }
}
