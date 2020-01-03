//
//  CartTableViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import UIKit
import BEMCheckBox

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var clotheImageView: UIImageView!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var clothNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var index: Int?
    private var isSelectedItem: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.checkBox.boxType = .square
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setClotheImage(by url: String) {
        clotheImageView.setImage(with: url)
    }
    
    func setSellerName(_ name: String) {
        sellerNameLabel.text = name
    }
    
    func setClotheNameLabel(_ name: String) {
        self.clothNameLabel.text = name
    }
    
    func setPriceLabel(_ price: String) {
        self.priceLabel.text = price
    }
    
    func setInitialInform(_ index: Int, _ isSelect: Bool) {
           self.index = index
           self.isSelectedItem = isSelect
    }
    
    func setCheckbox(_ isSelect: Bool) {
        if isSelect { checkBox.setOn(true, animated: false) }
        else { checkBox.setOn(false, animated: false) }
    }
    
    @IBAction func clickCheckbox(_ sender: Any) {
        NotificationCenter.default.post(name: .clickCartCheckBox, object: nil, userInfo: ["index": self.index, "isSelect": isSelectedItem])
    }
}
