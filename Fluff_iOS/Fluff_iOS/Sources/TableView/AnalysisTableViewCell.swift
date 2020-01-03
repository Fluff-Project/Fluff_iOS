//
//  AnalysisTableViewCell.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class AnalysisTableViewCell: UITableViewCell {

    @IBOutlet weak var clotheCollectionView: UICollectionView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var fluvShopLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var followButtonBackgroundImageView: UIImageView!
    @IBOutlet weak var clothtagLabel: UILabel!
    @IBOutlet weak var twoClothtagLabel: UILabel!
    
    private var clotheImages: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.clotheCollectionView.dataSource = self
        self.clotheCollectionView.delegate = self
        setInitialCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setClotheImages(imagesURL: [String]) {
        self.clotheImages = imagesURL
    }
    
    func setFluvProfileImage(url: String) {
        followButtonBackgroundImageView.makeCornerRounded(radius: followButtonBackgroundImageView.frame.width / 2)
        followButtonBackgroundImageView.clipsToBounds = true
        followButtonBackgroundImageView.setImage(with: url)
    }
    
    func setFluvShop(_ name: String) {
        fluvShopLabel.text = name
    }
    
    // 초기화 하는 코드
    private func setInitialCell() {
        followButton.makeCornerRounded(radius: followButton.frame.width / 5)
        clothtagLabel.layer.borderColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1.0).cgColor
        clothtagLabel.layer.borderWidth = 1.0
        clothtagLabel.textColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1.0)
        clothtagLabel.makeCornerRounded(radius: clothtagLabel.frame.width / 5.625)
        twoClothtagLabel.layer.borderColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1.0).cgColor
        twoClothtagLabel.layer.borderWidth = 1.0
        twoClothtagLabel.textColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1.0)
        twoClothtagLabel.makeCornerRounded(radius: twoClothtagLabel.frame.width / 5.625)
        
        fluvShopLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        
    }
}

extension AnalysisTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clotheImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fluvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "fluvCell", for: indexPath) as? FluvCollectionViewCell else { return UICollectionViewCell() }
        fluvCell.setProfileImage(url: clotheImages[indexPath.row])
        return fluvCell
    }
}

extension AnalysisTableViewCell: UICollectionViewDelegate {
    
}

extension AnalysisTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 28, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
