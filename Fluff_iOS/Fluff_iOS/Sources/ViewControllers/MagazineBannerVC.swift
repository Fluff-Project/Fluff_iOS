//
//  MagazineBannerVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import UIKit
import Hero

class MagazineBannerVC: UIViewController {
    
    private var userToken: String?
    private var magazineImageData: [MagazineImageData] = []
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    
    var now: Int = 0
    let title1List: [String] = ["2019년 12월,","광장시장 구제상가에서", "가치를 담은", "옷은 아니지만", "나만 알고 싶은"]
    let title2List: [String] = ["이 달의 베스트 빈티지 룩", "가을 옷 득템하기", "빈티지를 파는, Flapper", "빈티지", "SNS 빈티지 숍"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(pushView))
        rightSwipe.direction = .right
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(popView))
        rightSwipe.direction = .left
        
        self.view.addGestureRecognizer(rightSwipe)
        self.view.addGestureRecognizer(leftSwipe)
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initToken()
        requestMagazineImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userToken = nil
    }

    @objc func pushView(recognizer: UIGestureRecognizer) {
        print("푸시푸시")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MagazineBannerVC") as? MagazineBannerVC else { return }
        if now == 4 {
            return
        } else {
            nextVC.now = now + 1
        }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func popView(recognizer: UIGestureRecognizer) {
        print("팝팝")
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MagazineBannerVC") as? MagazineBannerVC else { return }
        if now == 0 {
            return
        } else {
            nextVC.now = now - 1
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func intoTheContents(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MagazineDetailVC") as? MagazineDetailVC else { return }
        nextVC.whatMagazine = now
        nextVC.magazineImageData = magazineImageData
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    private func initToken() {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        self.userToken = userToken
    }
}

extension MagazineBannerVC {
    private func requestMagazineImage() {
        guard let userToken = self.userToken else { return }
        MagazineService.shared.getMagazine(token: userToken) {
            networkResult in
            switch networkResult {
            case .success(let data):
                guard let magazineData = data as? MagazineJsonData else { return }
                self.magazineImageData = magazineData.data!
                self.backgroundImg.setImage(with: self.magazineImageData[self.now].imgUrl)
                self.title1Label.text = self.title1List[self.now]
                self.title2Label.text = self.title2List[self.now]
                self.backgroundImg.hero.id = self.magazineImageData[self.now]._id
            case .requestErr(let data):
                guard let magazineData = data as? MagazineData else { return }
                self.presentAlertController(title: magazineData.json!.message, message: nil)
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
