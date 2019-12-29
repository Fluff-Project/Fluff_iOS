//
//  DetailCategoryDataSource.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class DetailCategoryDataSource: NSObject, UICollectionViewDataSource {
    private var detailFilterData: [String] = []
    
    init(detailFilterData: [String]) {
        self.detailFilterData = detailFilterData
    }
    
    func setDetailFilterData(_ detailFilterData: [String]) {
        self.detailFilterData = detailFilterData
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailFilterData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCategoryCell", for: indexPath) as? DetailCategoryCollectionViewCell else { return UICollectionViewCell() }
        detailCategoryCell.layer.borderColor = UIColor.white.cgColor
        detailCategoryCell.layer.borderWidth = 1
        detailCategoryCell.makeCornerRounded(radius: detailCategoryCell.frame.width / 7)
        detailCategoryCell.setLabel(detailFilterData[indexPath.row])
        return detailCategoryCell
    }
}


class DetailCategoryDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    private var isSelectedDetailCategory: [Bool] = []
    
    init(isSelectedDetailCategory: [Bool]) {
        self.isSelectedDetailCategory = isSelectedDetailCategory
    }
    
    func setSelectedIndex(_ isSelectedDetailCategory: [Bool]) {
        self.isSelectedDetailCategory = isSelectedDetailCategory
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailFilterCell = collectionView.cellForItem(at: indexPath) as? DetailCategoryCollectionViewCell else { return }
        
        if isSelectedDetailCategory[indexPath.row] {
            isSelectedDetailCategory[indexPath.row] = false
            detailFilterCell.setNotSelected()
        } else {
            isSelectedDetailCategory[indexPath.row] = true
            detailFilterCell.setSelected()
        }
        
        NotificationCenter.default.post(name: .selectedDetailCategory, object: nil, userInfo: ["selectedIndex": indexPath.row, "isSelected": isSelectedDetailCategory[indexPath.row]])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 8*3) / 4
        let cellHeight = (collectionView.frame.height - 8) / 2
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
