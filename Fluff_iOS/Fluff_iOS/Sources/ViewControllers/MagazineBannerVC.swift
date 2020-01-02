//
//  MagazineBannerVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import UIKit

class MagazineBannerVC: UIViewController {
    
    private var userToken: String?
    private var magazineImageData: [MagazineImageData] = []
    @IBOutlet weak var backgroundImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initToken()
        requestMagazineImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userToken = nil
    }
    
    private func initToken() {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        self.userToken = userToken
    }
}

extension MagazineBannerVC {
    private func requestMagazineImage() {
        print("yo")
        guard let userToken = self.userToken else { return }
        print("yo1")
        MagazineService.shared.getMagazine(token: userToken) {
            networkResult in
            switch networkResult {
            case .success(let data):
                print("fuck1")
                guard let magazineData = data as? MagazineJsonData else {
                    print("장난치며 먹는 아이스크림")
                    return
                }
                self.magazineImageData = magazineData.data!
                for m in self.magazineImageData {
                    self.backgroundImg.setImage(with: m.imgUrl)
                }
                self.backgroundImg.setImage(with: self.magazineImageData[0].imgUrl)
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
