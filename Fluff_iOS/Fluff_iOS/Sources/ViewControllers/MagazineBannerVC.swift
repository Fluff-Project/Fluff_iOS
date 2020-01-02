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
    
    private var fuck: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(fuck.count))
 
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
                print("fuck")
                guard let magazineData = data as? MagazineJsonData else { return }
                self.magazineImageData = magazineData.data!
                for _ in self.magazineImageData {
                    self.fuck.append("F.U.C.K")
                }
            case .requestErr(let data):
                print("fuck")
                guard let magazineData = data as? MagazineData else { return }
                self.presentAlertController(title: magazineData.json.message, message: nil)
            case .pathErr:
                print("fuck")
                self.presentAlertController(title: "path Error", message: nil)
            case .serverErr:
                print("fuck")
                self.presentAlertController(title: "서버 오류", message: "서버 내부 오류가 있습니다.")
            case .networkFail:
                print("fuck")
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다")
            }
        }
    }
}
