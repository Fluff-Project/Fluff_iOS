//
//  AuctionVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/27.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class AuctionVC: UIViewController {

    @IBOutlet weak var auctionCollectionView: UICollectionView!
    
    private var auctionImage: [String] = ["auctionimage1", "auctionimage2", "auctionimage3"]
    private var auctionPrice: [String] = ["260,000", "320,000", "300,000"]
    private var timer: [String] = ["12:32:52", "13:42:55", "00:05:00"]
    
    var firstTimeLeft = 45172
    var secondTimeLeft = 49275
    var thirdTimeLeft = 300
    var timeCounter: Timer?
    private var auctionRealDatas: [AuctionRealData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeCounter = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        auctionCollectionView.delegate = self
        auctionCollectionView.dataSource = self
        loadAcutionData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func onTimerFires()
    {
        firstTimeLeft -= 1
        secondTimeLeft -= 1
        thirdTimeLeft -= 1
        
        timer[0] = secToTime(sec: firstTimeLeft)
        timer[1] = secToTime(sec: secondTimeLeft)
        timer[2] = secToTime(sec: thirdTimeLeft)

    }
    
    func secToTime(sec: Int) -> String {
        let hour = sec / 3600
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        return String(hour) + ":" + String(minute) + ":" + String(second)
    }
    
    private func loadAcutionData() {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        AcutionService.shared.getAuctionList(token: userToken) { networkResult in
            switch networkResult {
            case .success(let data):
                guard let auctionData = data as? AuctionData else { return }
                guard let auctionRealData = auctionData.json.data else { return }
                self.auctionRealDatas = auctionRealData
                self.auctionCollectionView.reloadData()
            case .requestErr(let message):
                guard let message = message as? String else { return }
                self.presentAlertController(title: message, message: nil)
            case .pathErr:
                self.presentAlertController(title: "경로 에러", message: nil)
            case .serverErr:
                self.presentAlertController(title: "서버 에러", message: nil)
            case .networkFail:
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다.")
            }
        }
    }

}

extension AuctionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return auctionRealDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let auctionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "auctionCell", for: indexPath) as? AuctionCollectionViewCell else { return UICollectionViewCell() }
        auctionCell.setImage(auctionRealDatas[indexPath.row].mainImg)
        auctionCell.setPrice(auctionRealDatas[indexPath.row].bid)
        auctionCell.setNameLabel(auctionRealDatas[indexPath.row].auctionName)

        return auctionCell
    }
}

extension AuctionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let auctionDetailVC = self.storyboard?.instantiateViewController(identifier: "auctionDetailVC") as? AuctionDetailVC else { return }
        auctionDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(auctionDetailVC, animated: true)
    }
    
}

extension AuctionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacingWidth = collectionView.frame.width / 23.4375
        return UIEdgeInsets(top: 8, left: spacingWidth, bottom: 20, right: spacingWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacingWidth: CGFloat = (collectionView.frame.width / 23.4375) * 2
        let auctionItemWidth: CGFloat = collectionView.frame.width - spacingWidth
        let auctionItemHeight: CGFloat = auctionItemWidth / 1.35
        return CGSize(width: auctionItemWidth, height: auctionItemHeight)
    }
}
