//
//  AnalysisHeaderTableViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class AnalysisHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var oneHashTagText: UILabel!
    @IBOutlet weak var twoHashTagText: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialHashTagText()
        initialButton()
    }
    
    private func initialHashTagText() {
        oneHashTagText.layer.borderColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1).cgColor
        oneHashTagText.layer.borderWidth = 1
        oneHashTagText.makeCornerRounded(radius: oneHashTagText.frame.width / 15)
        twoHashTagText.layer.borderColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1).cgColor
        twoHashTagText.layer.borderWidth = 1
        twoHashTagText.makeCornerRounded(radius: twoHashTagText.frame.width / 15)
    }
    
    private func initialButton() {
        followButton.makeCornerRounded(radius: followButton.frame.width / 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setHashTagLabel(one: String, two: String) {
        self.oneHashTagText.text = one
        self.twoHashTagText.text = two
    }
}
