//
//  TasteAnalysisVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/23.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class TasteAnalysisVC: UIViewController {

    @IBOutlet weak var tasteCollectionView: UICollectionView!
    @IBOutlet weak var selectButton: UIButton!
    private var selectedCount: Int = 0
    
    private var isSelected: [Bool] = []
    // 임시변수 선택 정할
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tasteCollectionView.dataSource = self
        tasteCollectionView.delegate = self
        initialButton()
        
        selectButton.setTitle("5개 이상 선택해주세요", for: .normal)
        
        for _ in 0..<30 {
            isSelected.append(false)
        }
    }
    
    private func initialButton() {
        selectButton.makeCornerRounded(radius: selectButton.frame.width / 15)
        selectButton.isUserInteractionEnabled = false
    }
    
    @IBAction func goAnalysisNext(_ sender: Any) {
        if selectedCount >= 5 {
            guard let nextAnalysisVC = self.storyboard?.instantiateViewController(identifier: "ThreeTasteAnalysisVC") as? NextTasteAnalysisVC else { return }
            nextAnalysisVC.modalPresentationStyle = .fullScreen
            self.present(nextAnalysisVC, animated: true, completion: nil)
        }
    }
}

extension TasteAnalysisVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let tasteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tasteCell", for: indexPath) as? TasteCollectionViewCell else { return UICollectionViewCell() }
        if isSelected[indexPath.row] { tasteCell.setCoverView() }
        else { tasteCell.hideCoverView() }
        return tasteCell
    }
}

//extension TasteAnalysisVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = (collectionView.frame.width-50) / 2
//        return CGSize(width: cellWidth, height: cellWidth)
//    }
//}

extension TasteAnalysisVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? TasteCollectionViewCell else { return }
        selectedCell.selected(isSelected[indexPath.row])
        
        if isSelected[indexPath.row] && selectedCount != 0 {
            selectedCount -= 1
        } else {
            selectedCount += 1
        }
        
        if selectedCount >= 5 {
            selectButton.backgroundColor = .black
            selectButton.titleLabel?.textColor = . white
            selectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            selectButton.setTitle("다음", for: .normal)
            selectButton.isUserInteractionEnabled = true
        } else {
            selectButton.backgroundColor = UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1.0)
            selectButton.titleLabel?.textColor = .white
            selectButton.setTitle("5개 이상을 선택해주세요", for: .normal)
            selectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            selectButton.isUserInteractionEnabled = false
        }
        
        isSelected[indexPath.row] = !isSelected[indexPath.row]
    }
}
