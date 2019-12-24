//
//  ShoppingVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class ShoppingVC: UIViewController {

    @IBOutlet weak var searchTextView: UITextView!
    @IBOutlet weak var shoppingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSearch()
        shoppingCollectionView.dataSource = self
        shoppingCollectionView.delegate = self
        self.setNavigationBarClear()
    }
    
    private func initialSearch() {
        searchTextView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        searchTextView.makeCornerRounded(radius: searchTextView.frame.width / 20)
    }
}


extension ShoppingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shoppingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingCell", for: indexPath)
        return shoppingCell
    }
}

extension ShoppingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width-2) / 2
        let height = width / 3 * 4
        return CGSize(width: width, height: height)
    }
}
