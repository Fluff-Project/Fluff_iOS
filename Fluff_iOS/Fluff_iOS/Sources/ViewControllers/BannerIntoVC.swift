//
//  BannerIntoVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class BannerIntoVC: UIViewController {
    
    @IBOutlet weak var bannerIntoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerIntoCollectionView.dataSource = self
        bannerIntoCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "15"), style: .done, target: self, action:
        #selector(popView))
        self.navigationController?.navigationBar.tintColor = .white
        self.setNavigationBarClear()
    }

    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BannerIntoVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bannerIntoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerIntoCollectionViewCell", for: indexPath) as! BannerIntoCollectionViewCell
        bannerIntoCollectionViewCell.bannerIntoImage.image = #imageLiteral(resourceName: "416")
        bannerIntoCollectionViewCell.bannerIntoItemLabel.text = "다홍꽃 주렁주렁 가디건"
        
        bannerIntoCollectionViewCell.bannerIntoPriceLabel.text = "98,000원"
        return bannerIntoCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BannerHeaderReusableView", for: indexPath) as! BannerHeaderReusableView
            
            header.headerImage.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
            
            return header
        default:
            assert(false)
        }
    }
}

extension BannerIntoVC: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (collectionView.frame.width - 91) / 2
    let cellHeight = cellWidth * (253 / 142)
    return CGSize(width: cellWidth, height: cellHeight)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 33, bottom: 0, right: 32)
    
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 29
    }
}

