//
//  ThemeIntoVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/30.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class ThemeIntoVC: UIViewController {

    @IBOutlet weak var themeIntoCollectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    
    var whatTheme: String?
    var titleStr = NSMutableAttributedString()
    var suggestionStr = NSMutableAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.attributedText = titleStr
        lineLabel.attributedText = suggestionStr
        
        themeIntoCollectionView.dataSource = self
        themeIntoCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavi()
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func setNavi() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .done, target: self, action:
        #selector(popView))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shoppingbagIc"), style: .done, target: self, action: #selector(goCartView))
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.setNavigationBarClear()
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goCartView() {
        let tasteStoryboard = UIStoryboard(name: "Taste", bundle: nil)
        guard let cartVC = tasteStoryboard.instantiateViewController(identifier: "CartVC") as? CartVC else { return }
        cartVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
}

extension ThemeIntoVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let themeIntoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeIntoCollectionViewCell", for: indexPath) as! ThemeIntoCollectionViewCell
        themeIntoCollectionViewCell.themeIntoImage.image = #imageLiteral(resourceName: "731435467565772314707755242100861709482025N")
        themeIntoCollectionViewCell.themeIntoItemLabel.text = "다홍꽃 주렁주렁 가디건"
        
        themeIntoCollectionViewCell.themeIntoPriceLabel.text = "98,000원"
        return themeIntoCollectionViewCell
    }
    
}


extension ThemeIntoVC: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (collectionView.frame.width - 91) / 2
    let cellHeight = cellWidth * (253 / 142)
    return CGSize(width: cellWidth, height: cellHeight)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 33, bottom: 0, right: 32)
    
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 29
    }
}

