//
//  FilteringVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/28.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import BEMCheckBox

class FilteringVC: UIViewController {
    @IBOutlet weak var backgroundEffectView: UIVisualEffectView!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet var colorLeadingSpacing: [NSLayoutConstraint]!
    @IBOutlet var colorTrailingSpacing: [NSLayoutConstraint]!
    
    @IBOutlet var colorButtons: [UIButton]!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var detailFilterView: UIView!
    @IBOutlet var detailFilterButtons: [UIButton]!
    @IBOutlet var sizeFilterButtons: [UIButton]!
    @IBOutlet weak var checkboxButton: BEMCheckBox!
    @IBOutlet weak var applyButton: UIButton!
    
    // Width, Height Proportion 초기 세부필터 안보이게 설정
    @IBOutlet weak var detailViewConstraint: NSLayoutConstraint!
    private var detailViewInitialHeight: CGFloat?
    
    private var isSelectedCategory: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initConstaint()
//        initBlurView()
        initSwipe()
        initColorButtons()
        setCollectionView()
        initDetailFilterButtons()
        initSizeFilterButtons()
        checkboxButton.boxType = .square
        checkboxButton.onAnimationType = .stroke
        checkboxButton.offAnimationType = .stroke
        applyButton.makeCornerRounded(radius: applyButton.frame.width / 15)
        initCategorySelected()
    }
    
    private func initBlurView() {
           backgroundEffectView.backgroundColor = .clear
           let blurEffect = UIBlurEffect(style: .dark)
           backgroundEffectView.effect = blurEffect
       }
    
    private func setCollectionView() {
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    
    private func initConstaint() {
        let widthSpacing = self.view.frame.width / 5.5147
        colorTrailingSpacing.forEach {
            $0.constant = widthSpacing
        }
        colorLeadingSpacing.forEach {
            $0.constant = widthSpacing
        }
        
        // detailFilter 안나오는 경우 설정
        detailViewInitialHeight = detailFilterView.frame.height
        detailFilterView.frame.size = CGSize(width: self.view.frame.width, height: 0)
        self.detailFilterView.layoutIfNeeded()
        // 이후 42로 contstant 지정
    }
    
    private func initColorButtons() {
        for button in colorButtons {
            button.makeCornerRounded(radius: button.frame.width/2)
            button.clipsToBounds = true
            button.setBackgroundColor(UIColor.black.withAlphaComponent(0.8), for: .highlighted)
        }
    }
    
    private func initDetailFilterButtons() {
        detailFilterButtons.forEach {
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 1
            $0.makeCornerRounded(radius: $0.frame.width / 8)
        }
    }
    
    private func initSizeFilterButtons() {
        sizeFilterButtons.forEach {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.white.cgColor
            $0.makeCornerRounded(radius: $0.frame.width / 5)
        }
    }
    
    private func initSwipe() {
        swipeView.makeCornerRounded(radius: swipeView.frame.width / 10)
    }
    
    private func initCategorySelected () {
        for _ in 0..<FilteringCategory.allCases.count {
            isSelectedCategory.append(false)
        }
    }
}

extension FilteringVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilteringCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        guard let category = FilteringCategory(rawValue: indexPath.row) else { return UICollectionViewCell() }
        
        if isSelectedCategory[indexPath.row] {
            guard let categoryImage = UIImage(named: category.getSelctImageName()) else { return UICollectionViewCell() }
            categoryCell.setcategoryImage(categoryImage)
            categoryCell.setCategoryLabelColor(UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1.0))
        } else {
            guard let categoryImage = UIImage(named: category.getNotSelectImageName()) else { return UICollectionViewCell() }
            categoryCell.setCategoryLabelColor(.white)
            categoryCell.setcategoryImage(categoryImage)
        }
        
        categoryCell.setCategoryLabel(name: category.getCategoryName())
        return categoryCell
    }
}

extension FilteringVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = FilteringCategory(rawValue: indexPath.row) else { return }
        guard let categoryCell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        if isSelectedCategory[indexPath.row] {
            guard let selectImage = UIImage(named: category.getNotSelectImageName()) else { return }
            categoryCell.setCategoryLabelColor(.white)
            categoryCell.setcategoryImage(selectImage)
        }
        else {
            guard let notSelectImage = UIImage(named: category.getSelctImageName()) else { return }
            categoryCell.setCategoryLabelColor(UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1))
            categoryCell.setcategoryImage(notSelectImage)
        }
        isSelectedCategory[indexPath.row] = !isSelectedCategory[indexPath.row]
        
//        for isSelect in isSelectedCategory {
//            if isSelect {
//                detailFilterView.frame.size = CGSize(width: self.view.frame.width, height: detailViewInitialHeight!)
//                detailFilterView.layoutIfNeeded()
//                break
//            }
//        }
    }
}

extension FilteringVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 6.4655, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionView.frame.width / 22.05, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width / 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
