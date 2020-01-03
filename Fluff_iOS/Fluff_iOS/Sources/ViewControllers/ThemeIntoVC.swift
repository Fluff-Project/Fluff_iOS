//
//  ThemeIntoVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/30.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class ThemeIntoVC: UIViewController {

    @IBOutlet weak var themeIntoCollectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    
    let numberFormatter = NumberFormatter()
    
    var userToken: String?
    var whatTheme: String?
    var titleStr = NSMutableAttributedString()
    var suggestionStr = NSMutableAttributedString()
    
    private var stockData: [StockData] = []
    private var styleData: [StyleData] = []
    private var clotheData: [ClotheData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.numberStyle = .decimal
        
        titleLabel.attributedText = titleStr
        lineLabel.attributedText = suggestionStr
        
        themeIntoCollectionView.dataSource = self
        themeIntoCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavi()
        switch whatTheme {
        case "Today":
            print("TD")
            requestTodayTheme()
        case "Recent":
            print("RE")
            requestRecentTheme()
        case "TodayVintage":
            print("Recommend")
            requestRecommendTheme()
        default :
            requestTodayTheme()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func setNavi() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .done, target: self, action:
        #selector(popView))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shoppingbagIc"), style: .done, target: self, action: #selector(goCartView))
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.setNavigationBarClear()
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goCartView() {
        let tasteStoryboard = UIStoryboard(name: "Taste", bundle: nil)
        guard let cartVC = tasteStoryboard.instantiateViewController(identifier: "CartVC") as? CartVC else { return }
        cartVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
}

extension ThemeIntoVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch whatTheme {
        case "Today":
            return stockData.count
        case "Recent":
            return styleData.count
        case "TodayVintage":
            return clotheData.count
        default:
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let themeIntoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeIntoCollectionViewCell", for: indexPath) as! ThemeIntoCollectionViewCell
        switch whatTheme {
        case "Today":
            themeIntoCollectionViewCell.themeIntoImage.setImage(with: stockData[indexPath.row].mainImg)
            themeIntoCollectionViewCell.themeIntoItemLabel.text = stockData[indexPath.row].goodsName
            themeIntoCollectionViewCell.themeIntoPriceLabel.text = numberFormatter.string(from: NSNumber(value: stockData[indexPath.row].price))! + "원"
            themeIntoCollectionViewCell.themeIntoSellerLabel.text = stockData[indexPath.row].sellerName
        case "Recent":
            themeIntoCollectionViewCell.themeIntoImage.setImage(with: styleData[indexPath.row].mainImg)
            themeIntoCollectionViewCell.themeIntoItemLabel.text = styleData[indexPath.row].goodsName
            themeIntoCollectionViewCell.themeIntoPriceLabel.text = numberFormatter.string(from: NSNumber(value: styleData[indexPath.row].price))! + "원"
            themeIntoCollectionViewCell.themeIntoSellerLabel.text = styleData[indexPath.row].sellerName
        case "TodayVintage":
        themeIntoCollectionViewCell.themeIntoImage.setImage(with: clotheData[indexPath.row].mainImg)
        themeIntoCollectionViewCell.themeIntoItemLabel.text = clotheData[indexPath.row].goodsName
        themeIntoCollectionViewCell.themeIntoPriceLabel.text = numberFormatter.string(from: NSNumber(value: clotheData[indexPath.row].price))! + "원"
            themeIntoCollectionViewCell.themeIntoSellerLabel.text = clotheData[indexPath.row].sellerName
        default:
            themeIntoCollectionViewCell.themeIntoImage.image = #imageLiteral(resourceName: "731435467565772314707755242100861709482025N")
            themeIntoCollectionViewCell.themeIntoItemLabel.text = "다홍꽃 주렁주렁 가디건"
            
            themeIntoCollectionViewCell.themeIntoPriceLabel.text = "98,000원"
        }
        
        return themeIntoCollectionViewCell
    }
    
}


extension ThemeIntoVC: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (collectionView.frame.width - 91) / 2
    let cellHeight = cellWidth * (253 / 142)
    return CGSize(width: cellWidth, height: cellHeight)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 33, bottom: 0, right: 32)
    
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 29
    }
}


extension ThemeIntoVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let tasteStoryboard = UIStoryboard(name: "Taste", bundle: nil)
            guard let detailVC = tasteStoryboard.instantiateViewController(identifier: "DetailViewController") as? DetailItemVC else { return }
        
        switch whatTheme {
        case "Today":
            detailVC.setGoodsId(stockData[indexPath.row]._id, stockData[indexPath.row].sellerId)
            detailVC.setPrice(stockData[indexPath.row].price)
            detailVC.setGoodsName(stockData[indexPath.row].goodsName)
            detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        case "Recent":
            detailVC.setGoodsId(styleData[indexPath.row]._id, styleData[indexPath.row].sellerId)
            detailVC.setPrice(styleData[indexPath.row].price)
            detailVC.setGoodsName(styleData[indexPath.row].goodsName)
            detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        case "TodayVintage":
            detailVC.setGoodsId(clotheData[indexPath.row]._id, clotheData[indexPath.row].sellerId)
            detailVC.setPrice(clotheData[indexPath.row].price)
            detailVC.setGoodsName(clotheData[indexPath.row].goodsName)
            detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        default:
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
            
    }
}

extension ThemeIntoVC {
    
private func requestTodayTheme() {
    guard let userToken = self.userToken else {return}
    
    TodayThemeService.shared.todayStock(token: userToken) {
        networkResult in
            switch networkResult {
            case .success(let data):
                guard let todayStockJsonData = data as? TodayStockJsonData else {return}
                print("흔들어주세요")
                self.stockData = todayStockJsonData.data!
                self.themeIntoCollectionView.reloadData()
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

    private func requestRecentTheme() {
    guard let userToken = self.userToken else {return}
    
    RecentThemeService.shared.recentStyle(token: userToken) {
        networkResult in
            switch networkResult {
            case .success(let data):
                guard let recentStyleJsonData = data as? RecentStyleJsonData else {return}
                self.styleData = recentStyleJsonData.data!
                self.themeIntoCollectionView.reloadData()
            case .requestErr(let data):
                guard let recentStyleJsonData = data as? RecentStyleJsonData else { return }
                self.presentAlertController(title: recentStyleJsonData.message, message: nil)
            case .pathErr:
                self.presentAlertController(title: "path Error", message: nil)
            case .serverErr:
                self.presentAlertController(title: "서버 오류", message: "서버 내부 오류가 있습니다.")
            case .networkFail:
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다")
            }
        }
        
    }
    
    private func requestRecommendTheme() {
    guard let userToken = self.userToken else {return}
    
    RecommendTheme.shared.getRecommendStyleClothe(token: userToken) {
        networkResult in
            switch networkResult {
            case .success(let data):
                guard let recommendedClotheJsonData = data as? RecommendedClotheJSONData else {return}
                self.clotheData = recommendedClotheJsonData.data!
                self.themeIntoCollectionView.reloadData()
            case .requestErr(let data):
                guard let recommendedClotheJsonData = data as? RecommendedClotheJSONData else { return }
                self.presentAlertController(title: recommendedClotheJsonData.message, message: nil)
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

