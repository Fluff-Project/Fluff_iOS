//
//  NextTasteAnalysisVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class NextTasteAnalysisVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var oneDescriptionLabel: UILabel!
    @IBOutlet weak var twoDescriptionLabel: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var followTableView: UITableView!
    
    private var sellers: [SellerData] = []
    
    private var analysisStatus: AnalysisStatus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        followTableView.dataSource = self
        followTableView.delegate = self
        initialCompleteButton()
        initFont()
        
        // 서버에서 Recommended 팔로워 가지고 오는 코드
        getRecommendedFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNaviBar()
    }
    
    private func initFont() {
        titleLabel.attributedText = NSMutableAttributedString(string: "당신이 좋아할만 한 플럽이에요!", attributes: [.font: UIFont(name: "S-CoreDream-5Medium", size: 24)!, .foregroundColor: UIColor.black, NSAttributedString.Key.kern: CGFloat(-1.92)])
        
        oneDescriptionLabel.attributedText = NSMutableAttributedString(string: "팔로우를 한 후, 멋진 상품을 놓치지말고", attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 15)!, .foregroundColor: UIColor.greyishBrown, NSAttributedString.Key.kern: CGFloat(-0.3)])
        twoDescriptionLabel.attributedText = NSMutableAttributedString(string: "바로바로 확인해보세요!", attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 15)!, .foregroundColor: UIColor.greyishBrown, NSAttributedString.Key.kern: CGFloat(-0.3)])
    }
    
    func setAnalysisStatus(_ analysisStatus: AnalysisStatus) {
        self.analysisStatus = analysisStatus
    }
    
    private func setNaviBar() {
        guard let analysisStatus = self.analysisStatus else { return }
        switch analysisStatus {
        case .signup:
            self.navigationController?.navigationBar.isHidden = true
        case .recommend:
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.tintColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
            self.navigationController?.navigationBar.topItem?.title = ""
            self.setNavigationBarClear()
        case .resetting:
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    private func initialCompleteButton() {
        completeButton.makeCornerRounded(radius: completeButton.frame.width / 13.6)
        
        guard let analysisStatus = self.analysisStatus else { return }
        switch analysisStatus {
        case .signup:
            completeButton.setTitle("가입 완료", for: .normal)
        case .resetting:
            completeButton.setTitle("설정 완료", for: .normal)
        case .recommend:
            completeButton.isHidden = true
        }
    }
    
    @IBAction func completeSignin(_ sender: Any) {
        guard let analysisStatus = self.analysisStatus else { return }
        switch analysisStatus {
        case .signup:
            guard let mainTabbarController = self.storyboard?.instantiateViewController(identifier: "WelcomeViewController") as? WelcomeViewController else { return }
            mainTabbarController.modalPresentationStyle = .fullScreen
            self.present(mainTabbarController, animated: true, completion: nil)
        case .resetting:
            self.navigationController?.popToRootViewController(animated: true)
        case .recommend:
            return
        }
    }
    
    private func getRecommendedFollowers() {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        RecommendService.shared.getRecommendFollowers(token: userToken) { networkResult in
            switch networkResult {
            case .success(let data):
                guard let follwerData = data as? RecommededFollowerData else { return }
                guard let parsingSellerData = follwerData.json.data else { return }
                self.sellers = parsingSellerData
                self.followTableView.reloadData()
            case .requestErr(_):
                self.presentAlertController(title: "조회 실패", message: nil)
            case .serverErr:
                self.presentAlertController(title: "서버 에러", message: nil)
            case .pathErr:
                self.presentAlertController(title: "경로 에러", message: nil)
            case .networkFail:
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다.")
            }
        }
    }
}

extension NextTasteAnalysisVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sellers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let analysisCell = tableView.dequeueReusableCell(withIdentifier: "analysisCell") as? AnalysisTableViewCell else { return UITableViewCell() }
        analysisCell.setClotheImages(imagesURL: sellers[indexPath.section].img)
        analysisCell.setFluvProfileImage(url: sellers[indexPath.section].sellerImg)
        analysisCell.setFluvShop(sellers[indexPath.section].sellerName)
        return analysisCell
    }
    
}

extension NextTasteAnalysisVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}
