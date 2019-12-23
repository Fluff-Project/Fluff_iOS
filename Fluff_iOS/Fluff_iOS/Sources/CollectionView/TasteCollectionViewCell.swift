//
//  TasteCollectionViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/23.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class TasteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var clotheImageView: UIImageView!
    var coverView: UIView?
    
    func selected(_ isSelected: Bool) {
        if isSelected {
            coverView?.removeFromSuperview()
        } else {
            let coverView = UIView(frame: self.clotheImageView.frame)
            coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            self.addSubview(coverView)
        }
        
        let coverView = UIView(frame: self.clotheImageView.frame)
        coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.addSubview(coverView)
    }
}
