//
//  ShopCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shopImageView: UIImageView!
    
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var clotheNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    // heart 눌렀는지 User에 대한 모델 들어올거임
    
    func setShopImageView(imageName: String) {
        guard let shoppingImage = UIImage(named: imageName) else { return }
        shopImageView.image = shoppingImage
    }
    
    func setSellerName(_ name: String) {
        sellerNameLabel.textColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
        sellerNameLabel.text = name
    }
    
    func setClotheName(_ name: String) {
        clotheNameLabel.text = name
    }
    
    func setPriceLabel(_ price: String) {
        priceLabel.text = price
    }
    
    @IBAction func clickHeartButton(_ sender: Any) {
        guard let heartFill = UIImage(systemName: "heart.fill") else { return }
        heartButton.setBackgroundImage(heartFill, for: .normal)
        
        // 만약 눌렀으면 확인해서 heart 이미지로
    }
}
