//
//  HomeVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import CHIPageControl

class HomeVC: UIViewController {

    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageControl: CHIPageControlJalapeno!
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var todayLineLabel: UILabel!
    @IBOutlet weak var recentCollectionView: UICollectionView!
    @IBOutlet weak var recentLabel: UILabel!
    @IBOutlet weak var recentLineLabel: UILabel!
    @IBOutlet weak var howFluvLabel: UILabel!
    @IBOutlet weak var howFluvLineLabel: UILabel!
    @IBOutlet weak var howFluvCollectionView: UICollectionView!
    @IBOutlet weak var nowAuctionCollectionView: UICollectionView!
    @IBOutlet weak var nowAuctionLabel: UILabel!
    @IBOutlet weak var auctionLineLabel: UILabel!
    @IBOutlet weak var todayVintageLabel: UILabel!
    @IBOutlet weak var todayVintageLineLabel: UILabel!
    @IBOutlet weak var todayVintageCollectionView: UICollectionView!
    
    private var userToken: String?
    private var fluvData: [FluvData] = []
    
    private var howFluvNameList: [String] = []
    private var howFluvImgList: [String] = []
    
    var current_y: CGFloat = 0
    let sCoreMedium = UIFont(name: "S-CoreDream-5Medium", size: 24)
    let sCoreExtraLight = UIFont(name: "S-CoreDream-2ExtraLight", size: 24)
    let koDotumPL = UIFont(name: "KoPubWorldDotumPL", size: 15)
    let forYou: String = "당신을 위한 "
    var whatSeen = String()
    let recommendVintage: String = "의 추천 빈티지"
    var dayOfTheWeek = String()
    var todayAttributedStr = NSMutableAttributedString()
    var recentAttributedStr = NSMutableAttributedString()
    
    var howFluvAttributedStr = NSMutableAttributedString()
    
    var nowAuctionAttributedStr = NSMutableAttributedString()
    
    var todayVintageAttributedStr = NSMutableAttributedString()
    
    var recentLineAttributedStr = NSMutableAttributedString()
    
    lazy var attributes: [NSAttributedString.Key: Any] = [.kern: -1.44, .font: sCoreMedium as Any]
    
    lazy var attributes2: [NSAttributedString.Key: Any] = [.kern: -0.3, .font: koDotumPL as Any]
    
    lazy var todayLineAttributedStr = NSMutableAttributedString(string: "고민하는 순간, 다음은 없어요~", attributes: attributes2)
    lazy var howFluvLineAttributedStr =  NSMutableAttributedString(string: "회원님이 좋아할 만한 셀러에요", attributes: attributes2)
    lazy var auctionLineAttributedStr = NSMutableAttributedString(string: "플러프에만 있는 유니크 빈티지", attributes: attributes2)
    lazy var todayVintageLineAttributedStr = NSMutableAttributedString(string: "오늘은 이런 빈티지 어떨까요?", attributes: attributes2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whatSeen = "무스탕"
        dayOfTheWeek = "화요일"
        
                
        todayAttributedStr = NSMutableAttributedString(string: todayLabel.text!)
        
        recentAttributedStr = NSMutableAttributedString(string: forYou + whatSeen)
        
        howFluvAttributedStr = NSMutableAttributedString(string: howFluvLabel.text!)
        
        nowAuctionAttributedStr = NSMutableAttributedString(string: nowAuctionLabel.text!)
        
        todayVintageAttributedStr = NSMutableAttributedString(string: dayOfTheWeek + recommendVintage)
        
        recentLineAttributedStr = NSMutableAttributedString(string: "최근에 " + whatSeen + "을 많이 보셨군요? 이런 건 어때요?", attributes: attributes2)
        
        
        todayAttributedStr.addAttributes(attributes, range: NSRange(location: 0, length: 2))
        recentAttributedStr.addAttributes(attributes, range: NSRange(location: 7, length: whatSeen.count))
        howFluvAttributedStr.addAttributes(attributes, range: NSRange(location: 3, length: 2))
        nowAuctionAttributedStr.addAttributes(attributes, range: NSRange(location: 8, length: 2))
        todayVintageAttributedStr.addAttributes(attributes, range: NSRange(location: 0, length: 3))
        
        todayLabel.attributedText = todayAttributedStr
        recentLabel.attributedText = recentAttributedStr
        howFluvLabel.attributedText = howFluvAttributedStr
        nowAuctionLabel.attributedText = nowAuctionAttributedStr
        todayVintageLabel.attributedText = todayVintageAttributedStr
        recentLineLabel.attributedText = recentLineAttributedStr
        todayLineLabel.attributedText = todayLineAttributedStr
        howFluvLineLabel.attributedText = howFluvLineAttributedStr
        auctionLineLabel.attributedText = auctionLineAttributedStr
        todayVintageLineLabel.attributedText = todayVintageLineAttributedStr
        bannerCollectionView.dataSource = self
        todayCollectionView.dataSource = self
        recentCollectionView.dataSource = self
        howFluvCollectionView.dataSource = self
        nowAuctionCollectionView.dataSource = self
        todayVintageCollectionView.dataSource = self
        howFluvCollectionView.delegate = self
        bannerCollectionView.delegate = self
        bannerCollectionView.showsHorizontalScrollIndicator = false
        todayCollectionView.showsHorizontalScrollIndicator = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        initToken()
        requestHowFluv()
    }
    
    private func initToken() {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        self.userToken = userToken
    }
    
    @IBAction func goTodayTheme(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ThemeIntoVC") as? ThemeIntoVC else { return }
        nextVC.whatTheme = "Today"
        nextVC.titleStr = todayAttributedStr
        nextVC.suggestionStr = todayLineAttributedStr
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func goRecentTheme(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ThemeIntoVC") as? ThemeIntoVC else { return }
        nextVC.whatTheme = "Recent"
        nextVC.titleStr = recentAttributedStr
        nextVC.suggestionStr = recentLineAttributedStr
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func goTodayVintageTheme(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ThemeIntoVC") as? ThemeIntoVC else { return }
        nextVC.whatTheme = "TodayVintage"
        nextVC.titleStr = todayVintageAttributedStr
        nextVC.suggestionStr = todayVintageLineAttributedStr
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func goFluvRecomend(_ sender: Any) {
        let tasteStoryboard = UIStoryboard(name: "Taste", bundle: nil)
        guard let fluvRecommendVC = tasteStoryboard.instantiateViewController(identifier: "ThreeTasteAnalysisVC") as? NextTasteAnalysisVC else { return }
        fluvRecommendVC.setAnalysisStatus(.recommend)
        self.navigationController?.pushViewController(fluvRecommendVC, animated: true)
    }
}


extension HomeVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("정민아 merge하자")
        return fluvData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bannerImgList: [UIImage] = [#imageLiteral(resourceName: "beccaMchaffieFzde6ITjkwUnsplash2"),#imageLiteral(resourceName: "beccaMchaffieFzde6ITjkwUnsplash2"),#imageLiteral(resourceName: "beccaMchaffieFzde6ITjkwUnsplash2"),#imageLiteral(resourceName: "beccaMchaffieFzde6ITjkwUnsplash2")]
        let todayImgList: [UIImage] = [#imageLiteral(resourceName: "84"), #imageLiteral(resourceName: "416"), #imageLiteral(resourceName: "416"), #imageLiteral(resourceName: "84")]
        let recentImgList: [UIImage] = [#imageLiteral(resourceName: "kakaoTalkPhoto2019121905141717"),#imageLiteral(resourceName: "kakaoTalkPhoto2019121905141716"),#imageLiteral(resourceName: "kakaoTalkPhoto2019121905141717"),#imageLiteral(resourceName: "kakaoTalkPhoto2019121905141716")]
        let nowAuctionImgList: [UIImage] = [#imageLiteral(resourceName: "111"),#imageLiteral(resourceName: "110"),#imageLiteral(resourceName: "111"),#imageLiteral(resourceName: "110")]
        let todayVintageImgList: [UIImage] = [#imageLiteral(resourceName: "kakaoTalkPhoto2019121905141728"),#imageLiteral(resourceName: "kakaoTalkPhoto201912190514179"),#imageLiteral(resourceName: "kakaoTalkPhoto2019121905141728"),#imageLiteral(resourceName: "kakaoTalkPhoto201912190514179")]
        
        let todayProductList: [String] = ["빗살무늬 폴로 셔츠", "다홍꽃 주렁주렁 가디건", "빗살무늬 폴로 셔츠", "다홍꽃 주렁주렁 가디건"]
        let nowAuctionItemList: [String] = ["Yves Saint Laurent 원피스", "MaxMara 만다린 자켓", "Yves Saint Laurent 원피스", "MaxMara 만다린 자켓"]
        let nowAuctionTimeList: [String] = ["곧 경매 종료", "종료까지 2시간", "곧 경매 종료", "종료까지 2시간"]
        let todayVintageProductList: [String] = ["오베이 갈매기 패턴 캠프캡", "폴로 스포츠 블루 덕다운 패딩", "오베이 갈매기 패턴 캠프캡", "폴로 스포츠 블루 덕다운 패딩"]
        let starNumList: [Int] = [2,4,5,1]
        
        switch collectionView {
            
        case self.todayCollectionView:
            let todayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCollectionViewCell", for: indexPath) as! TodayCollectionViewCell
        todayCollectionViewCell.todayImage.image = todayImgList[indexPath.row]
        todayCollectionViewCell.todayProductLabel.text = todayProductList[indexPath.row]
            return todayCollectionViewCell
            
        case self.bannerCollectionView:
            
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            
            bannerCell.bannerImg.image = bannerImgList[indexPath.row]
            return bannerCell
        
        case self.recentCollectionView:
            let recentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCollectionViewCell", for: indexPath) as! RecentCollectionViewCell
        
        recentCollectionViewCell.recentImage.image = recentImgList[indexPath.row]
        recentCollectionViewCell.recentProductLabel.text = todayProductList[indexPath.row]
            return recentCollectionViewCell
            
        case self.howFluvCollectionView:
            let howFluvCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HowFluvCollectionViewCell", for: indexPath) as! HowFluvCollectionViewCell
            print(String(fluvData.count))
            howFluvCollectionViewCell.fluvName.text = fluvData[indexPath.row].sellerName
            howFluvCollectionViewCell.fluvProfileImage.setImage(with: fluvData[indexPath.row].sellerImg)
            switch starNumList[indexPath.row] {
            
            case 1:
                howFluvCollectionViewCell.star1.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star2.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star3.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star4.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star5.image = #imageLiteral(resourceName: "starGreyIc")
            case 2:
                howFluvCollectionViewCell.star1.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star2.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star3.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star4.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star5.image = #imageLiteral(resourceName: "starGreyIc")
            case 3:
                howFluvCollectionViewCell.star1.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star2.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star3.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star4.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star5.image = #imageLiteral(resourceName: "starGreyIc")
            case 4:
                howFluvCollectionViewCell.star1.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star2.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star3.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star4.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star5.image = #imageLiteral(resourceName: "starGreyIc")
            case 5:
                howFluvCollectionViewCell.star1.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star2.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star3.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star4.image = #imageLiteral(resourceName: "starYellowIc")
                howFluvCollectionViewCell.star5.image = #imageLiteral(resourceName: "starYellowIc")
            default:
                howFluvCollectionViewCell.star1.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star2.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star3.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star4.image = #imageLiteral(resourceName: "starGreyIc")
                howFluvCollectionViewCell.star5.image = #imageLiteral(resourceName: "starGreyIc")
            }
            
            howFluvCollectionViewCell.howFluvView.backgroundColor = UIColor.white
            howFluvCollectionViewCell.howFluvView.layer.borderColor = UIColor.borderGrey.cgColor
            
            howFluvCollectionViewCell.howFluvView.layer.borderWidth = 1
        
            return howFluvCollectionViewCell
            
        case self.nowAuctionCollectionView:
            let nowAuctionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowAuctionCollectionViewCell", for: indexPath) as! NowAuctionCollectionViewCell
            
            nowAuctionCollectionViewCell.nowAuctionImage.image = nowAuctionImgList[indexPath.row]
            
            nowAuctionCollectionViewCell.nowAuctionGradient.image = #imageLiteral(resourceName: "478")
            nowAuctionCollectionViewCell.nowAuctionItem.text = nowAuctionItemList[indexPath.row]
            
            nowAuctionCollectionViewCell.nowAuctionTime.text = nowAuctionTimeList[indexPath.row]
            
            return nowAuctionCollectionViewCell
        case self.todayVintageCollectionView:
            let todayVintageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayVintageCollectionViewCell", for: indexPath) as! TodayVintageCollectionViewCell
            
            todayVintageCollectionViewCell.todayVintageImage.image = todayVintageImgList[indexPath.row]
            todayVintageCollectionViewCell.todayVintageProductLabel.text = todayVintageProductList[indexPath.row]
                return todayVintageCollectionViewCell
            
        default:
        return UICollectionViewCell()
        }
    }
    
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
        case self.bannerCollectionView:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case self.howFluvCollectionView:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case self.howFluvCollectionView:
            return 12
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case self.howFluvCollectionView:
            return 12
        default:
            return 0
        }
        
    }
}

extension HomeVC: UICollectionViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.bannerCollectionView.frame.width)
      self.bannerPageControl.set(progress: page, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "BannerIntoVC") as? BannerIntoVC else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HomeVC {
    private func requestHowFluv() {
        guard let userToken = self.userToken else {
            return
        }
        HowFluvService.shared.howFluv(token: userToken) {
            networkResult in
            switch networkResult {
            case .success(let data):
                guard let howFluvJsonData = data as? HowFluvJsonData else { return }
                self.fluvData = howFluvJsonData.data!
                self.howFluvCollectionView.reloadData()
            case .requestErr(let data):
                guard let howFluvJsonData = data as? HowFluvJsonData else { return }
                self.presentAlertController(title: howFluvJsonData.message, message: nil)
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
