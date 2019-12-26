//
//  ShoppingVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class ShoppingVC: UIViewController {

    @IBOutlet weak var shoppingCollectionView: UICollectionView!
    @IBOutlet weak var backgroundSearchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSearch()
        shoppingCollectionView.dataSource = self
        shoppingCollectionView.delegate = self
        self.setNavigationBarClear()
    }
    
    private func initialSearch() {
        backgroundSearchView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        backgroundSearchView.makeCornerRounded(radius: backgroundSearchView.frame.width / 20)
        searchTextField.backgroundColor = .clear
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

extension ShoppingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailItemVC else { return }
        
        // 선택된 Index Model 다음 뷰에 전달
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//extension ShoppingVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let estimateHeight = collectionView.frame.height / 2
//        let estimateWidth = estimateHeight / 2 + 5
//        return CGSize(width: estimateWidth, height: estimateHeight)
//    }
//}
