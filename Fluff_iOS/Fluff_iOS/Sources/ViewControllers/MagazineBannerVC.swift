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
    @IBOutlet var wholeView: UIView!
    var now: Int = 0
    
    

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

//    @IBAction func intoTheContents(_ sender: UIButton) {
//        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MagazineDetailVC") as? MagazineDetailVC else { return }
//        self.navigationController?.pushViewController(nextVC, animated: false)
//    }
    
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
