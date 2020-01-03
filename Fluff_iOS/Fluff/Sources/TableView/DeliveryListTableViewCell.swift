//
//  DeliveryListTableViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class DeliveryListTableViewCell: UITableViewCell {

    @IBOutlet weak var deliveryProductImage: UIImageView!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
