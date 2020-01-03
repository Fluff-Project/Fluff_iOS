//
//  BannerIntoVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class BannerIntoVC: UIViewController {
    
    @IBOutlet weak var bannerIntoCollectionView: UICollectionView!
    
    let numberFormatter = NumberFormatter()
    
    var styleData: [StyleData] = []
    
    var userToken: String?
    var bannerLineStr = String()
    var bannerTitleStr = String()
    var bannerImg = UIImage()
    
    var whatBanner = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.numberStyle = .decimal
        
        bannerIntoCollectionView.dataSource = self
        bannerIntoCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "15"), style: .done, target: self, action:
        #selector(popView))
        self.navigationController?.navigationBar.tintColor = .white
        self.setNavigationBarClear()
        
        switch whatBanner {
        case 0:
            print("가")
            requestCardigan()
        case 1:
            print("스")
            requestSkirt()
        case 2:
            print("원")
            requestOnePiece()
        case 3:
            print("코")
            requestCoat()
        default:
            print("디")
            return
        }
    }

    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BannerIntoVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return styleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bannerIntoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerIntoCollectionViewCell", for: indexPath) as! BannerIntoCollectionViewCell
        bannerIntoCollectionViewCell.bannerIntoImage.setImage(with: styleData[indexPath.row].img[0])
        bannerIntoCollectionViewCell.bannerIntoItemLabel.text = styleData[indexPath.row].goodsName
        bannerIntoCollectionViewCell.bannerIntoPriceLabel.text = numberFormatter.string(from: NSNumber(value: styleData[indexPath.row].price))! + "원"
        bannerIntoCollectionViewCell.bannerIntoSellerLabel.text = styleData[indexPath.row].sellerName
        return bannerIntoCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BannerHeaderReusableView", for: indexPath) as! BannerHeaderReusableView
            
            header.headerImage.image = bannerImg
            header.headerLineLabel.text = bannerLineStr
            header.headerTitleLabel.text = bannerTitleStr
            header.headerImage.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
            
            return header
        default:
            assert(false)
        }
    }
}

extension BannerIntoVC: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (collectionView.frame.width - 91) / 2
    let cellHeight = cellWidth * (253 / 142)
    return CGSize(width: cellWidth, height: cellHeight)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 33, bottom: 0, right: 32)
    
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 29
    }
}

extension BannerIntoVC {
    private func requestCardigan() {
        guard let userToken = self.userToken else {
            return
        }
        
        BannerIntoService.shared.getCardigan(token: userToken) {
            networkResult in
            switch networkResult {
            case .success(let data):
                
                guard let recentStyleJsonData = data as? RecentStyleJsonData else {
                    print("요")
                    return
                    
                }
                self.styleData = recentStyleJsonData.data!
                self.bannerIntoCollectionView.reloadData()
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
    
    private func requestSkirt() {
        guard let userToken = self.userToken else {return}
        
        BannerIntoService.shared.getSkirt(token: userToken) {
            networkResult in
            switch networkResult {
            case .success(let data):
                guard let recentStyleJsonData = data as? RecentStyleJsonData else {return}
                self.styleData = recentStyleJsonData.data!
                self.bannerIntoCollectionView.reloadData()
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
    
    private func requestOnePiece() {
        guard let userToken = self.userToken else {return}
        
        BannerIntoService.shared.getOnePiece(token: userToken) {
            networkResult in
            switch networkResult {
            case .success(let data):
                guard let recentStyleJsonData = data as? RecentStyleJsonData else {return}
                self.styleData = recentStyleJsonData.data!
                self.bannerIntoCollectionView.reloadData()
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
    
    private func requestCoat() {
        guard let userToken = self.userToken else {return}
        
        BannerIntoService.shared.getCoat(token: userToken) {
            networkResult in
            switch networkResult {
            case .success(let data):
                guard let recentStyleJsonData = data as? RecentStyleJsonData else {return}
                self.styleData = recentStyleJsonData.data!
                self.bannerIntoCollectionView.reloadData()
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

}

