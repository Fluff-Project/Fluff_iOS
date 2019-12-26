//
//  LikeListTabVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/26.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LikeListTabVC: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var likeCollectionView: UICollectionView!
    @IBOutlet weak var searchResultLabel: UILabel!
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard let likeImage = UIImage(named: "favoriteClothesIcSelected") else { return IndicatorInfo(title: "") }
        return IndicatorInfo(image: likeImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        likeCollectionView.dataSource = self
        likeCollectionView.delegate = self
        searchResultLabel.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        
    }
}

extension LikeListTabVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let likeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "likeCell", for: indexPath) as? LikeCollectionViewCell else { return UICollectionViewCell() }
        
        return likeCell
    }
    
    
}

extension LikeListTabVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let widthSpacingProportion: CGFloat = 11.36
        return UIEdgeInsets(top: 0, left: collectionView.frame.width / widthSpacingProportion, bottom: 0, right: collectionView.frame.width / widthSpacingProportion)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellSpacingProportion: CGFloat = 14.42
        return collectionView.frame.width / cellSpacingProportion
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacingProportion: CGFloat = 14.42
        let widthSpacingProportion: CGFloat = 11.36
        
        let widthSpacing = (collectionView.frame.width / widthSpacingProportion) * 2
        let cellSpacing = collectionView.frame.width / cellSpacingProportion
        
        let cellWidth = (collectionView.frame.width - widthSpacing - cellSpacing) / 2
        let cellHeight = cellWidth * 1.7957
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
