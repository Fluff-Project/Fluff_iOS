//
//  AuctionDetailVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/27.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class AuctionDetailVC: UIViewController {

    @IBOutlet weak var auctionImageCollectionView: UICollectionView!
    @IBOutlet weak var biddingButton: UIButton!
    @IBOutlet weak var clotheNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var apllicantLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionNameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var auctionDetailScrollView: UIScrollView!
    
    private var auctionImage: UIImage?
    private var auctionName: String?
    private var auctionPrice: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialNavi()
        initButton()
//        auctionDetailScrollView.delegate = self
        auctionImageCollectionView.delegate = self
        auctionImageCollectionView.dataSource = self
    }
    
    private func initialNavi() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        self.setNavigationBarClear()
    }
    
    private func initButton() {
        biddingButton.makeCornerRounded(radius: biddingButton.frame.width / 13)
    }
}

extension AuctionDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 || scrollView.contentOffset.x < 0 {
            scrollView.contentOffset.x = 0
        }
    }
}

extension AuctionDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailAuctionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "auctionDetailCell", for: indexPath) as? AuctionDetailCollectionViewCell else { return UICollectionViewCell() }
        
        return detailAuctionCell
    }
}

extension AuctionDetailVC: UICollectionViewDelegateFlowLayout {
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
