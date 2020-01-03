//
//  OtherItemDelegate.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class OtherItemDelegate: NSObject, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    private var otherItems: [OtherItemData] = []
    private var sellerID: String = ""
    private var navigationController = UINavigationController()
    
    func setOtherItems(_ otherItem: [OtherItemData]) {
        self.otherItems = otherItem
    }
    
    func setSellerID(_ id: String) {
        self.sellerID = id
    }
    
    func setNavigationController (_ nav: UINavigationController) {
        self.navigationController = nav
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tasteStoryboard = UIStoryboard(name: "Taste", bundle: nil)
        guard let detailVC = tasteStoryboard.instantiateViewController(identifier: "DetailViewController") as? DetailItemVC else { return }
        detailVC.setGoodsId(self.otherItems[indexPath.row]._id, self.sellerID)
        detailVC.setPrice(self.otherItems[indexPath.row].price)
        detailVC.setGoodsName(self.otherItems[indexPath.row].goodsName)
        detailVC.hidesBottomBarWhenPushed = true
         navigationController.pushViewController(detailVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
