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
    let numberFormatter = NumberFormatter()
    
    private var stockData: [StockData] = []
    private var userToken: String?
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard let likeImage = UIImage(named: "favoriteClotheslcSelected1") else { return IndicatorInfo(title: "ㅁㅈㅇㅁㅈㅇ") }
        return IndicatorInfo(image: likeImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        likeCollectionView.dataSource = self
        likeCollectionView.delegate = self
        searchResultLabel.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        numberFormatter.numberStyle = .decimal
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initToken()
        requestTodayStock()
    }
    
    private func initToken() {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        self.userToken = userToken
    }
    
}

extension LikeListTabVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let likeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "likeCell", for: indexPath) as? LikeCollectionViewCell else { return UICollectionViewCell() }
        likeCell.likeImage.setImage(with: stockData[indexPath.row].mainImg)
        likeCell.clotheNameLabel.text = stockData[indexPath.row].goodsName
        likeCell.priceLabel.text =
            numberFormatter.string(from: NSNumber(value: stockData[indexPath.row].price))!
        print(String(indexPath.row * 103))
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

extension LikeListTabVC {
    private func requestTodayStock() {
        guard let userToken = self.userToken else {return}
        
        TodayStockService.shared.todayStock(token: userToken) {
            networkResult in
            switch networkResult {
            case .success(let data):
                guard let todayStockJsonData = data as? TodayStockJsonData else {return}
                print(todayStockJsonData)
                guard let stockData = todayStockJsonData.data else { return }
                self.stockData = stockData
                self.likeCollectionView.reloadData()
            case .requestErr(let data):
                guard let todayStockJsonData = data as? TodayStockJsonData else { return }
                self.presentAlertController(title: todayStockJsonData.message, message: nil)
            case .pathErr:
                self.presentAlertController(title: "path Error", message: nil)
            case .serverErr:
                self.presentAlertController(title: "서버 오류", message: "서버 내부 오류가 있습니다.")
            case .networkFail:
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다")
            }
        }
        
    }
}
