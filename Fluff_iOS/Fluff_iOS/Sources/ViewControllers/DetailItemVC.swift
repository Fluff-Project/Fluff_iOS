//
//  DetailItemVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class DetailItemVC: UIViewController {
    @IBOutlet weak var detailItemCollectionView: UICollectionView!
    
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
    
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var otherItemCollectionView: UICollectionView!
    
    private var isClicked: Bool = false
    
    private var otherItemCollectionViewDataSource: OtherItemDataSource = OtherItemDataSource(otherItems: ["20191217115522", "20191218120524", "20191218120650"])
    private var otherItemDelegate: OtherItemDelegate = OtherItemDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detailItemCollectionView.dataSource = self
        detailItemCollectionView.delegate = self
        otherItemCollectionView.dataSource = otherItemCollectionViewDataSource
        otherItemCollectionView.delegate = otherItemDelegate
        self.setNavigationBarClear()
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        initalButton()
    }
    
    private func initalButton() {
        followButton.makeCornerRounded(radius: followButton.frame.width / 7)
        purchaseButton.makeCornerRounded(radius: purchaseButton.frame.width / 13)
    }
    
    private func initialNavi() {
        
    }
    
    @IBAction func clickPurchase(_ sender: Any) {
        guard let purchaseVC = self.storyboard?.instantiateViewController(identifier: "PurchaseViewController") as? PurchaseViewController else { return }
        self.navigationController?.pushViewController(purchaseVC, animated: true)
    }
    
    @IBAction func clickHeart(_ sender: Any) {
        if isClicked {
            guard let heartImage = UIImage(named: "heartEmptyIc") else { return }
            heartButton.setBackgroundImage(heartImage, for: .normal)
            isClicked = !isClicked
        } else {
            guard let heartImage = UIImage(named: "heartFilledIc") else { return }
            heartButton.setBackgroundImage(heartImage, for: .normal)
            isClicked = !isClicked
        }
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

extension DetailItemVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
