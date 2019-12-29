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
    
    var whatTheme: String?
    var titleStr = NSMutableAttributedString()
    var suggestionStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeIntoCollectionView.dataSource = self
        themeIntoCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ThemeIntoCollectionReusableView", for: indexPath) as! ThemeIntoCollectionReusableView
            
            header.titleLabel.attributedText = titleStr
            header.suggestionLabel.text = suggestionStr
            return header
        default:
            assert(false)
        }
            
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

