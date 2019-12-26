//
//  HomeVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import CHIPageControl

class HomeVC: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageControl: CHIPageControlJalapeno!
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerCollectionView.dataSource = self
        todayCollectionView.dataSource = self
        bannerCollectionView.delegate = self
       bannerCollectionView.showsHorizontalScrollIndicator = false
        todayCollectionView.showsHorizontalScrollIndicator = false

        
        // Do any additional setup after loading the view.
    }

}

extension HomeVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bannerImgList: [UIImage] = [#imageLiteral(resourceName: "beccaMchaffieFzde6ITjkwUnsplash2"),#imageLiteral(resourceName: "beccaMchaffieFzde6ITjkwUnsplash2"),#imageLiteral(resourceName: "beccaMchaffieFzde6ITjkwUnsplash2"),#imageLiteral(resourceName: "beccaMchaffieFzde6ITjkwUnsplash2")]
        
        let todayImgList: [UIImage] = [#imageLiteral(resourceName: "84"), #imageLiteral(resourceName: "416"), #imageLiteral(resourceName: "416"), #imageLiteral(resourceName: "84")]
        let todayProductList: [String] = ["빗살무늬 폴로 셔츠", "다홍꽃 주렁주렁 가디건", "빗살무늬 폴로 셔츠", "다홍꽃 주렁주렁 가디건"]
        
        switch collectionView {
            
        case self.todayCollectionView:
            print("todayCollectionview")
            let todayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCollectionViewCell", for: indexPath) as! TodayCollectionViewCell
        todayCollectionViewCell.todayImage.image = todayImgList[indexPath.row]
        todayCollectionViewCell.todayProductLabel.text = todayProductList[indexPath.row]
            return todayCollectionViewCell
            
        case self.bannerCollectionView:
            print("bannerCollectionView")
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            
            bannerCell.bannerImg.image = bannerImgList[indexPath.row]
            return bannerCell
            
        default:
        return UICollectionViewCell()
        }
    }
    
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeVC: UICollectionViewDelegate {

func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let page = Int(targetContentOffset.pointee.x / self.bannerCollectionView.frame.width)
  self.bannerPageControl.set(progress: page, animated: true)
}
}
