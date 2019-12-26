//
//  FollowingListVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/26.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FollowingListVC: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var followingTableView: UITableView!
    private var isFollow: [Bool] = []
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard let followingImage = UIImage(named: "favoriteMarketIcSelected") else { return IndicatorInfo(title: "") }
        return IndicatorInfo(image: followingImage)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        followingTableView.delegate = self
        followingTableView.dataSource = self
        
        for _ in 0..<30 {
            self.isFollow.append(false)
        }
    }
}

extension FollowingListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let followingCell = tableView.dequeueReusableCell(withIdentifier: "FollowingCell") as? FollowingTableViewCell else { return UITableViewCell() }
        followingCell.separatorInset = UIEdgeInsets.zero
        followingCell.setInit()
        followingCell.setFollowButton(isFollow: isFollow[indexPath.row])
        return followingCell
    }
}

extension FollowingListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 7
    }
}
