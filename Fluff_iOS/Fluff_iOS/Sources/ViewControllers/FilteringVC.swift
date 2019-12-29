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
    @IBOutlet weak var swipeArea: UIView!
    
    @IBOutlet weak var backgroundEffectView: UIVisualEffectView!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet var colorLeadingSpacing: [NSLayoutConstraint]!
    @IBOutlet var colorTrailingSpacing: [NSLayoutConstraint]!
    
    @IBOutlet var colorButtons: [UIButton]!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet var sizeFilterButtons: [UIButton]!
    @IBOutlet weak var checkboxButton: BEMCheckBox!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var detailFilterStackView: UIStackView!
    @IBOutlet weak var detailFilterStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailFilterLabelView: UIView!
    @IBOutlet weak var detailFilterTitleLabel: UILabel!
    
    @IBOutlet weak var detailCategoryCollectionView: UICollectionView!
    private var detailCategoryCollectionViewDataSource: DetailCategoryDataSource = DetailCategoryDataSource(detailFilterData: ["자켓", "가디건", "점퍼", "야상", "베스트", "코트"])
    private var detailCategoryDelegate: DetailCategoryDelegateFlowLayout = DetailCategoryDelegateFlowLayout(detailFilterData: ["자켓", "가디건", "점퍼", "야상", "베스트", "코트"])
    
    private var isSelectedColor: [Bool] = []
    private var isSelectedCategory: [Bool] = []
    private var isSelectedSize: [Bool] = []
    private var isSelectedDetailCategory: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSwipeArea()
        initConstaint()
        initSwipe()
        initColorButtons()
        setCollectionView()
        initSizeFilterButtons()
        checkboxButton.boxType = .square
        checkboxButton.onAnimationType = .stroke
        checkboxButton.offAnimationType = .stroke
        applyButton.makeCornerRounded(radius: applyButton.frame.width / 15)
        initCategorySelected()
    }
    
    private func setSwipeArea() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideView))
        swipeGesture.direction = .down
        swipeArea.addGestureRecognizer(swipeGesture)
    }
    
    @objc func hideView() {
        print("swipe")
//        NotificationCenter.default.post(name: <#T##NSNotification.Name#>, object: <#T##Any?#>, userInfo: <#T##[AnyHashable : Any]?#>)
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
        
        detailCategoryCollectionView.register(UINib(nibName: "DetailCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "detailCategoryCell")
        detailCategoryCollectionView.dataSource = detailCategoryCollectionViewDataSource
        detailCategoryCollectionView.delegate = detailCategoryDelegate
        detailCategoryCollectionView.reloadData()
    }
    
    private func initConstaint() {
        let widthSpacing = self.view.frame.width / 5.5147
        colorTrailingSpacing.forEach {
            $0.constant = widthSpacing
        }
        colorLeadingSpacing.forEach {
            $0.constant = widthSpacing
        }
    }
    
    private func initColorButtons() {
        for button in colorButtons {
            button.makeCornerRounded(radius: button.frame.width/2)
            button.clipsToBounds = true
            button.setBackgroundColor(UIColor.black.withAlphaComponent(0.8), for: .highlighted)
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
        
        for _ in 0..<sizeFilterButtons.count {
            isSelectedSize.append(false)
        }
        
        for _ in 0..<colorButtons.count {
            isSelectedColor.append(false)
        }
    }
    
    @IBAction func clickColorButtons(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        for index in 0..<colorButtons.count {
            if button === colorButtons[index] {
                changeColorButton(selectedColorButton: button, selectedIndex: index)
                break
            }
        }
    }
    
    private func changeColorButton(selectedColorButton: UIButton, selectedIndex: Int) {
        guard let selectedColor = ColorCategory(rawValue: selectedIndex) else { return }
        if isSelectedColor[selectedIndex] {
            isSelectedColor[selectedIndex] = false
            selectedColorButton.layer.borderWidth = 0
        } else {
            isSelectedColor[selectedIndex] = true
            selectedColorButton.layer.borderWidth = 2
            selectedColorButton.layer.borderColor = selectedColor.getBorderColor()
            
            for index in 0..<colorButtons.count {
                if isSelectedColor[index] && index != selectedIndex {
                    isSelectedColor[index] = false
                    colorButtons[index].layer.borderWidth = 0
                }
            }
        }
    }
    
    @IBAction func clickFilterButtons(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        switch button {
        case sizeFilterButtons[0]: changeSizeButton(selectedSizeButton: sizeFilterButtons[0], selectedIndex: 0)
        case sizeFilterButtons[1]: changeSizeButton(selectedSizeButton: sizeFilterButtons[1], selectedIndex: 1)
        case sizeFilterButtons[2]: changeSizeButton(selectedSizeButton: sizeFilterButtons[2], selectedIndex: 2)
        case sizeFilterButtons[3]: changeSizeButton(selectedSizeButton: sizeFilterButtons[3], selectedIndex: 3)
        case sizeFilterButtons[4]: changeSizeButton(selectedSizeButton: sizeFilterButtons[4], selectedIndex: 4)
        default: return
        }
    }
    
    private func changeSizeButton(selectedSizeButton: UIButton, selectedIndex: Int) {
        if isSelectedSize[selectedIndex] {
            isSelectedSize[selectedIndex] = false
            sizeFilterButtons[selectedIndex].setTitleColor(.white, for: .normal)
            sizeFilterButtons[selectedIndex].layer.borderColor = UIColor.white.cgColor
            sizeFilterButtons[selectedIndex].layer.borderWidth = 1
        } else {
            isSelectedSize[selectedIndex] = true
            sizeFilterButtons[selectedIndex].setTitleColor(UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1), for: .normal)
            sizeFilterButtons[selectedIndex].layer.borderColor = UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1).cgColor
            sizeFilterButtons[selectedIndex].layer.borderWidth = 1
        }
    }
    
    @IBAction func setClear(_ sender: Any) {
        for index in 0..<isSelectedCategory.count {
            isSelectedCategory[index] = false
            categoryCollectionView.reloadData()
        }
        
        for index in 0..<isSelectedSize.count {
            if isSelectedSize[index] {
                changeSizeButton(selectedSizeButton: sizeFilterButtons[index], selectedIndex: index)
            }
        }
        
        for index in 0..<isSelectedColor.count {
            if isSelectedColor[index] {
                changeColorButton(selectedColorButton: colorButtons[index], selectedIndex: index)
            }
        }
    }
    
    @IBAction func clickApply(_ sender: Any) {
        NotificationCenter.default.post(name: .clickApplyButton, object: nil, userInfo: nil)
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
        if isSelectedCategory[indexPath.row] {
            guard let category = FilteringCategory(rawValue: indexPath.row) else { return }
            guard let categoryCell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
            guard let notSelectedImage = UIImage(named: category.getNotSelectImageName()) else { return }
            isSelectedCategory[indexPath.row] = false
            categoryCell.setCategoryLabelColor(.white)
            categoryCell.setcategoryImage(notSelectedImage)
        } else {
            guard let category = FilteringCategory(rawValue: indexPath.row) else { return }
            guard let categoryCell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
            guard let selectedImage = UIImage(named: category.getSelctImageName()) else { return }
            categoryCell.setcategoryImage(selectedImage)
            categoryCell.setCategoryLabelColor(UIColor(red: 250/255, green: 31/255, blue: 147/255, alpha: 1))
            isSelectedCategory[indexPath.row] = true
            
            for index in 0..<isSelectedCategory.count {
                if index != indexPath.row && isSelectedCategory[index] == true {
                    isSelectedCategory[index] = false
                    guard let category = FilteringCategory(rawValue: index) else { return }
                    guard let categoryCell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? CategoryCollectionViewCell else { return }
                    guard let notSelectedImage = UIImage(named: category.getNotSelectImageName()) else { return }
                    categoryCell.setcategoryImage(notSelectedImage)
                    categoryCell.setCategoryLabelColor(.white)
                }
            }
        }
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
