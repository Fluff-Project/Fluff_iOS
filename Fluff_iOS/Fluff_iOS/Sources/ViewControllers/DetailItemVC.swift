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
    
    @IBAction func clickPurchase(_ sender: Any) {
        guard let purchaseVC = self.storyboard?.instantiateViewController(identifier: "PurchaseViewController") as? PurchaseViewController else { return }
        self.navigationController?.pushViewController(purchaseVC, animated: true)
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
    
    func setFont(title: String, price: String) {
        clotheNameLabel.attributedText = NSMutableAttributedString(string: title, attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 20)!, .foregroundColor: UIColor.black , NSAttributedString.Key.kern: CGFloat(-0.6)])
        priceLabel.attributedText = NSMutableAttributedString(string: price, attributes: [.font: UIFont(name: "S-CoreDream-6Bold", size: 25)!, .foregroundColor: UIColor.black, NSAttributedString.Key.kern: -0.25])
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
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.view.frame.width)
        pageControl.set(progress: page, animated: true)
    }
}

extension DetailItemVC: UICollectionViewDelegateFlowLayout {
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

