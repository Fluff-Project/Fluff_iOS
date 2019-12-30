//
//  CartVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/30.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import BEMCheckBox

class CartVC: UIViewController {

    @IBOutlet weak var cartListLabel: UILabel!
    @IBOutlet weak var allSelectCheckBox: BEMCheckBox!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var cartListTableView: UITableView!
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initButton()
        initNavi()
        cartListTableView.dataSource = self
        cartListTableView.delegate = self
        self.navigationItem.title = "장바구니"
        setLeftButton()
    }
    
    private func setLeftButton() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "10"), style: .done, target: self, action: #selector(popView))
    }
    
    @objc func popView() {
        print("POP")
        self.navigationController?.popViewController(animated: true)
    }
    
    private func initNavi() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
    }
    
    private func initButton() {
        allSelectCheckBox.onAnimationType = .stroke
        allSelectCheckBox.offAnimationType = .stroke
        allSelectCheckBox.boxType = .square
        deleteButton.layer.borderColor = UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1.0).cgColor
        deleteButton.layer.borderWidth = 1
        deleteButton.makeCornerRounded(radius: deleteButton.frame.width/4)
        
        buyButton.makeCornerRounded(radius: buyButton.frame.width / 14.333)
        buyButton.clipsToBounds = true
    }
}

extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.view.layoutSubviews()
        guard let cartListCell = tableView.dequeueReusableCell(withIdentifier: "cartListCell") as? CartListTableViewCell else { return UITableViewCell() }
        return cartListCell
    }
}

extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 324
    }
}

extension CartVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cartItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartItemCell", for: indexPath) as? CartItemCollectionViewCell else { return UICollectionViewCell() }
        return cartItemCell
    }
}

extension CartVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height / 2.189, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CartVC: UICollectionViewDelegate {
    
}
