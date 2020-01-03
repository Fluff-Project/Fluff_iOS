//
//  MyPageTableViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMenuText(_ text: String) {
        menuLabel.text = text
        menuLabel.textColor = UIColor(red: 58/255, green: 64/255, blue: 71/255, alpha: 1.0) 
    }

}
