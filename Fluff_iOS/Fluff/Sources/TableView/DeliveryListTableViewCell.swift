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
    
    func setImage(_ url: String) {
        deliveryProductImage.setImage(with: url)
    }
    
    func setSellerName(_ sellerName: String) {
        sellerNameLabel.text = sellerName
    }
    
    func setProductNameLabel(_ productName: String) {
        productNameLabel.text = productName
    }
    
    func setPrice(_ price: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattingString = (numberFormatter.string(from: NSNumber(value: price)) ?? "0")
        productPriceLabel.text = formattingString
    }
}
