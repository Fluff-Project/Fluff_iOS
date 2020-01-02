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
    
    private var otherItemCollectionViewDataSource: OtherItemDataSource = OtherItemDataSource(otherItems: ["20191217115522", "20191218120524", "20191218120650"])
    private var otherItemDelegate: OtherItemDelegate = OtherItemDelegate()
    
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
        pageControlConstraint.constant = detailItemCollectionView.frame.origin.y + detailItemCollectionView.frame.height - 65
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
//        guard let purchaseVC = self.storyboard?.instantiateViewController(identifier: "PurchaseViewController") as? PurchaseViewController else { return }
//        purchaseVC.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(purchaseVC, animated: true)
        self.presentAlertController(title: "장바구니 담기 성공", message: "장바구니에 담겼습니다.")
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

extension DetailItemVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as? DetailItemCollectionViewCell else { return UICollectionViewCell() }
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

