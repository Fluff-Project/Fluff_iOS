//
//  LikeListVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/26.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class LikeListParentVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initNavi()
    }
    
    private func initNavi() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
