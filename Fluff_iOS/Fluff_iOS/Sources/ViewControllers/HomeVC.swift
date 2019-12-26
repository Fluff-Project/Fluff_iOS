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
    
    var bannerList = [Banner]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBanner()
        
        todayCollectionView.dataSource = self
        todayCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeVC {
    func setBanner() {
        let banner1 = Banner(bannerName: "beccaMchaffieFzde6ITjkwUnsplash2")
        let banner2 = Banner(bannerName: "beccaMchaffieFzde6ITjkwUnsplash2")
        let banner3 = Banner(bannerName: "beccaMchaffieFzde6ITjkwUnsplash2")
        let banner4 = Banner(bannerName: "beccaMchaffieFzde6ITjkwUnsplash2")
        let banner5 = Banner(bannerName: "beccaMchaffieFzde6ITjkwUnsplash2")
        
        bannerList = [banner1, banner2, banner3, banner4, banner5]
    }
    
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let todayImgList: [UIImage] = [#imageLiteral(resourceName: "84"), #imageLiteral(resourceName: "416"), #imageLiteral(resourceName: "416"), #imageLiteral(resourceName: "84")]
        let todayProductList: [String] = ["빗살무늬 폴로 셔츠", "다홍꽃 주렁주렁 가디건", "빗살무늬 폴로 셔츠", "다홍꽃 주렁주렁 가디건"]
        
        let todayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCollectionViewCell", for: indexPath) as! TodayCollectionViewCell
        todayCollectionViewCell.todayImage.image = todayImgList[indexPath.row]
        todayCollectionViewCell.todayPriceLabel.text = todayProductList[indexPath.row]
        
        
        let bannerCell: BannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        
        
        let banner = bannerList[indexPath.row]
        bannerCell.image?.image = banner.bannerImg
        return bannerCell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        print(currentPage)
        self.bannerPageControl.set(progress: currentPage, animated: true)
        
    }
}
