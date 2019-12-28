//
//  KeywordTableViewCell.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/28.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class KeywordTableViewCell: UITableViewCell {

    @IBOutlet weak var keywordButton: UIButton!
    @IBOutlet weak var keywordImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
