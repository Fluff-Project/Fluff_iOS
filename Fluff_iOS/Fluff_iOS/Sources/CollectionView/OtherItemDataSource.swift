//
//  OtherItemDataSource.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class OtherItemDataSource: NSObject, UICollectionViewDataSource {
    private var otherItems: [OtherItemData] = []
    
    override init() {}
    
    func setOtherItems(_ otherItems: [OtherItemData]) {
        print(otherItems.count)
        self.otherItems = otherItems
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherItemCell", for: indexPath) as? OtherItemCollectionViewCell else { return UICollectionViewCell() }
//        otherItems[indexPath.row]._id
//        otherItems[indexPath.row].goodsName
//        otherItems[indexPath.row].mainImg
//        otherItems[indexPath.row].price
        
        detailCell.setClotheImage(otherItems[indexPath.row].mainImg)
        detailCell.setName("\(otherItems[indexPath.row].goodsName)")
        detailCell.setPrice("\(otherItems[indexPath.row].price)")
        return detailCell
    }
}
