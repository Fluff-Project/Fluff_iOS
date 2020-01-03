//
//  DetailItemVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import CHIPageControl

class DetailItemVC: UIViewController {
    @IBOutlet weak var detailItemCollectionView: UICollectionView!
    
    @IBOutlet weak var sellerTextView: UITextView!
    @IBOutlet weak var clotheNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var pageControl: CHIPageControlJalapeno!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var otherItemCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControlConstraint: NSLayoutConstraint!
    private var isClicked: Bool = false
    
    private var otherItemCollectionViewDataSource: OtherItemDataSource = OtherItemDataSource()
    private var otherItemDelegate: OtherItemDelegate = OtherItemDelegate()
    
    private var goodsId: String?
    private var sellerId: String?
    private var price: Int?
    private var detailItemInform: DetailGoodsData?
    private var otherItemDataOfSeller: [OtherItemData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialButton()
        setNavi()
        detailItemCollectionView.dataSource = self
        detailItemCollectionView.delegate = self
        otherItemCollectionView.dataSource = otherItemCollectionViewDataSource
        otherItemCollectionView.delegate = otherItemDelegate
        self.setNavigationBarClear()
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        pageControlConstraint.constant = detailItemCollectionView.frame.origin.y + detailItemCollectionView.frame.height - 70
        
        loadDatilItemData()
        loadOtherItemOfSeller()
    }
    
    func setGoodsId(_ goodsId: String, _ sellerId: String) {
        self.goodsId = goodsId
        self.sellerId = sellerId
    }
    
    func setPrice(_ price: Int) {
        self.price = price
    }
    
    private func initialButton() {
        followButton.makeCornerRounded(radius: followButton.frame.width / 7)
        purchaseButton.makeCornerRounded(radius: purchaseButton.frame.width / 13)
    }
    
    private func setNavi() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "10"), style: .done, target: self, action:
        #selector(popView))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shoppingbagIc"), style: .done, target: self, action: #selector(goCartView))
    }
    
    @objc func goCartView() {
        guard let cartVC = self.storyboard?.instantiateViewController(identifier: "CartVC") as? CartVC else { return }
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickPurchase(_ sender: Any) {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        guard let goodsId = self.goodsId else { return }
        CartService.shared.addCart(token: userToken, goodsItem: goodsId) { networkResult in
            switch networkResult {
            case .success(let data):
                guard let cartStatusData = data as? CartStatusData else { return }
                guard let cartData = cartStatusData.json.data else { return }
                self.presentAlertController(title: "장바구니 추가", message: "장바구니에 담겼습니다.")
            case .requestErr(let data):
                guard let cartStatusData = data as? CartStatusData else { return }
                print("message: \(cartStatusData.json.message)")
                self.presentAlertController(title: cartStatusData.json.message, message: nil)
            case .pathErr:
                self.presentAlertController(title: "경로 에러", message: nil)
            case .serverErr:
                self.presentAlertController(title: "서버 에러", message: nil)
            case .networkFail:
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다.")
            }
        }
    }

    @IBAction func clickHeart(_ sender: Any) {
        if isClicked {
            guard let heartImage = UIImage(named: "heartEmptyIc-1") else { return }
            heartButton.setBackgroundImage(heartImage, for: .normal)
            isClicked = !isClicked
        } else {
            guard let heartImage = UIImage(named: "heartFilledIc-1") else { return }
            heartButton.setBackgroundImage(heartImage, for: .normal)
            isClicked = !isClicked
        }
    }
    
    func setSellerTalk(talk: String) {
        sellerTextView.attributedText = NSMutableAttributedString(string: talk, attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 14), .foregroundColor: UIColor.greyishBrown, NSAttributedString.Key.kern: -0.42])
    }
}

extension DetailItemVC {
    private func loadDatilItemData() {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        guard let clotheId = self.goodsId else { return }
        DetailInformRequestService.shared.requestDetailInform(token: userToken, goodsId: clotheId) { networkResult in
            switch networkResult {
            case .success(let data):
                guard let detailGoodsData = data as? DetailGoodsDataStatus else { return }
                guard let detailGoods = detailGoodsData.json.data else { return }
                self.detailItemInform = detailGoods
                self.setDetailView()
                guard let price = self.price else { return }
                self.priceLabel.text = "\(price)"
                self.detailItemCollectionView.reloadData()
                self.otherItemCollectionView.reloadData()
            case .requestErr(let data):
                // 팝업창 띄우고 확인 누를 시 이전 화면으로 처리
                guard let detailGoodsData = data as? DetailGoodsDataStatus else { return }
                self.presentAlertController(title: detailGoodsData.json.message, message: nil)
            case .pathErr:
                // 팝업창 띄우고 확인 누를 시 이전 화면으로 처리
                self.presentAlertController(title: "잘못된 경로입니다.", message: nil)
            case .serverErr:
                // 팝업창 띄우고 확인 누를 시 이전화면으로 처리
                self.presentAlertController(title: "서버 오류", message: "서버에서 데이터를 받아오지 못했습니다.")
            case .networkFail:
                // 팝업창 띄으고 확인 누를 시 이전화면으로 처리
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다.")
            }
        }
    }
    
    private func loadOtherItemOfSeller() {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        guard let sellerId = self.sellerId else { return }
        SellerItemLookupService.shared.lookupOtherItem(sellerId: sellerId, token: userToken) { networkResult in
            switch networkResult {
            case .success(let data):
                guard let sellerOtherJSONData = data as? SellerOtherData else { return }
                guard let otherItems = sellerOtherJSONData.json.data else { return }
                self.otherItemDataOfSeller = otherItems
                self.otherItemCollectionViewDataSource.setOtherItems(self.otherItemDataOfSeller)
                self.otherItemCollectionView.reloadData()
            case .requestErr(let data):
                guard let sellerOtherJSONData = data as? SellerOtherJSONData else { return }
                self.presentAlertController(title: sellerOtherJSONData.message, message: nil)
            case .pathErr:
                self.presentAlertController(title: "경로 오류", message: nil)
            case .serverErr:
                self.presentAlertController(title: "서버 오류", message: nil)
            case .networkFail:
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결에 실패하였습니다.")
            }
        }
    }
    
    private func setDetailView() {
        guard let detailItemInform = self.detailItemInform else { return }
        statusLabel.text = "\(detailItemInform.condition)"
        sizeLabel.text = detailItemInform.size
        sellerTextView.text = detailItemInform.comment
    }
}

extension DetailItemVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let detailInform = self.detailItemInform else { return 0 }
        return detailInform.img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as? DetailItemCollectionViewCell else { return UICollectionViewCell() }
        guard let detailItemInform = self.detailItemInform else { return UICollectionViewCell() }
        detailCell.setClotheImageBy(url: detailItemInform.img[indexPath.row])
        return detailCell
    }
}

extension DetailItemVC: UICollectionViewDelegate {
    
}

extension DetailItemVC: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.view.frame.width)
        pageControl.set(progress: page, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
