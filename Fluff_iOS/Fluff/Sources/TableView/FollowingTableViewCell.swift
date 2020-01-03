//
//  FollowingTableViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/26.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {
    @IBOutlet weak var fluvNameLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var oneTagLabel: UILabel!
    @IBOutlet weak var twoTagLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var followButtonWidthConstraint: NSLayoutConstraint!
    private var isFollow: Bool?
    private var cellRow: Int?
    
    override func awakeFromNib() {
        initTagLabel()
        initFont()
    }
    
    private func initFont() {
        fluvNameLabel.attributedText = NSMutableAttributedString(string: "빈티지나라", attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 15)!, .foregroundColor: UIColor.black,
                                                                                                         NSAttributedString.Key.kern: CGFloat(-0.45)])
        followerCountLabel.attributedText = NSMutableAttributedString(string: "팔로워 294명", attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 11)!, .foregroundColor: UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)])
        followButton.titleLabel?.attributedText = NSMutableAttributedString(string: "팔로우", attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 14)!, NSAttributedString.Key.kern: -0.42])
        
    }
    
    private func initTagLabel() {
        oneTagLabel.makeCornerRounded(radius: oneTagLabel.frame.width / 6)
        oneTagLabel.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1).cgColor
        oneTagLabel.layer.borderWidth = 1
        twoTagLabel.makeCornerRounded(radius: twoTagLabel.frame.width / 6)
        twoTagLabel.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1).cgColor
        twoTagLabel.layer.borderWidth = 1
    }
    
    func setFluvName(_ name: String) {
        fluvNameLabel.text = name
    }
    
    func setFollowerCountLabel(_ count: String) {
        followerCountLabel.text = "팔로워 " + count + "명"
    }
    
    func setOneTagLabel(_ tag: String) {
        oneTagLabel.text = tag
    }
    
    func setTwoTagLabel(_ tag: String) {
        twoTagLabel.text = tag
    }
    
    func setRow(_ row: Int) {
        cellRow = row
    }
    
    func setFollowButton(isFollow: Bool) {
        self.isFollow = isFollow
        followButton.clipsToBounds = true
        if isFollow {
            // 팔로우 취소 누르는 버튼
            followButtonWidthConstraint.constant = self.frame.width / 4.9
            followButton.setTitleColor(.white, for: .highlighted)
            followButton.setBackgroundColor(.black, for: .highlighted)
            followButton.layer.borderColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1.0).cgColor
            followButton.layer.borderWidth = 1
            followButton.setTitleColor(UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1), for: .normal)
            followButton.setTitle("팔로우 취소", for: .normal)
            followButton.setBackgroundColor(UIColor.white, for: .normal)
        } else {
            // 팔로우 누르는 버튼
            followButtonWidthConstraint.constant = self.frame.width / 6.694
            followButton.setBackgroundColor(.white, for: .highlighted)
            followButton.layer.borderColor = UIColor.black.cgColor
            followButton.layer.borderWidth = 1
            followButton.setBackgroundColor(.black, for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.setTitle("팔로우", for: .normal)
        }
    }
    
    @IBAction func clickFollowButton(_ sender: Any) {
        NotificationCenter.default.post(name: .clickFollowButton, object: nil, userInfo: ["row": cellRow, "isFollow": isFollow])
    }
}
