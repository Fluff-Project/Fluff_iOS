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
    func setShopImageView(url: String) {
        shopImageView.setImage(with: url)
    }
    
    func setSellerName(_ name: String) {
        sellerNameLabel.attributedText = NSMutableAttributedString(string: "\(name)", attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 12)!, .foregroundColor: UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1.0), NSAttributedString.Key.kern: CGFloat(-0.48)])
    }
    
    func setClotheName(_ name: String) {
        clotheNameLabel.text = name
        clotheNameLabel.attributedText = NSMutableAttributedString(string: "\(name)", attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 14), .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1), NSAttributedString.Key.kern: CGFloat(-0.42)])
    }
    
    func setPriceLabel(_ price: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattingNumber = (numberFormatter.string(from: NSNumber(value: price)) ?? "0") + "원"
        priceLabel.attributedText = NSMutableAttributedString(string: formattingNumber, attributes: [.font: UIFont(name: "S-CoreDream-5Medium", size: 15), .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1.0), NSAttributedString.Key.kern: CGFloat(-0.3)])
        
    }
    
    @IBAction func clickHeartButton(_ sender: Any) {
        guard let heartFill = UIImage(systemName: "heart.fill") else { return }
        heartButton.setBackgroundImage(heartFill, for: .normal)
        
        // 만약 눌렀으면 확인해서 heart 이미지로
    }
}
