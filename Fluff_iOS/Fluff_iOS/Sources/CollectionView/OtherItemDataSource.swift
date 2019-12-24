//
//  OtherItemDataSource.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class OtherItemDataSource: NSObject, UICollectionViewDataSource {
    private var otherItems: [String]?
    
    init(otherItems: [String]) {
        self.otherItems = otherItems
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemCount = otherItems?.count else { return 0 }
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherItemCell", for: indexPath) as? OtherItemCollectionViewCell else { return UICollectionViewCell() }
        
        guard let otherItem = otherItems?[indexPath.row] else { return UICollectionViewCell() }
        guard let clotheImage = UIImage(named: otherItem) else { return UICollectionViewCell() }
        detailCell.setClotheImage(clotheImage)
        
        return detailCell
    }
}
