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
    
    private var filteringVC: FilteringVC!
    private var transparentView: UIView!
    private var coverBlurView: UIVisualEffectView!
    
    @IBOutlet weak var filterButton: UIButton!
    
    private var filterCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addObserver()
        initButton()
        shoppingCollectionView.dataSource = self
        shoppingCollectionView.delegate = self
        self.setNavigationBarClear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        initFilterfing()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.filteringVC.view.removeFromSuperview()
        self.transparentView.removeFromSuperview()
        self.coverBlurView.removeFromSuperview()
    }
    
    private func initButton() {
        filterButton.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
        filterButton.setTitle("필터", for: .normal)
        filterButton.makeCornerRounded(radius: filterButton.frame.width / 6)
        filterButton.makeShadow(opacity: 0.16, radius: 6)
    }
    
    private func initFilterfing() {
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let tabbarHeight = self.tabBarController?.tabBar.frame.height else { return }
        
        transparentView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height + tabbarHeight))
        transparentView.backgroundColor = .clear
        let slideDownGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewWhenSlidUpAppear))
        transparentView.addGestureRecognizer(slideDownGesture)
        window.addSubview(transparentView)
        transparentView.alpha = 0
        
        let filteringViewEstimateHeight = (self.view.bounds.height + tabbarHeight) / 1.0958
        coverBlurView = UIVisualEffectView(frame: CGRect(x: 0, y: self.view.bounds.height + tabbarHeight, width: self.view.bounds.width, height: filteringViewEstimateHeight))
        let blurEffect = UIBlurEffect(style: .dark)
        coverBlurView.backgroundColor = .clear
        coverBlurView.effect = blurEffect
        coverBlurView.makeCornerRounded(radius: coverBlurView.frame.width / 15)
        coverBlurView.clipsToBounds = true
        window.addSubview(coverBlurView)

        filteringVC = FilteringVC(nibName: "FilteringVC", bundle: nil)
        filteringVC?.view.frame = CGRect(x: 0, y: self.view.bounds.height + tabbarHeight , width: self.view.bounds.width, height: filteringViewEstimateHeight)
        filteringVC.view.makeCornerRounded(radius: filteringVC.view.frame.width / 20)
        window.addSubview(filteringVC.view)
    }
    
    @objc func tapViewWhenSlidUpAppear() {
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.filteringVC.view.transform = .identity
            self.coverBlurView.transform = .identity
        }, completion: nil)
    }
    
    @IBAction func slideupFilteringView(_ sender: Any) {
        transparentView.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.filteringVC.view.transform = CGAffineTransform(translationX: 0, y: -self.filteringVC.view.frame.height)
            self.coverBlurView.transform = CGAffineTransform(translationX: 0, y: -self.coverBlurView.frame.height)
        }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identiriler = segue.identifier else { return }
        if identiriler == "cartSegue" {
            segue.destination.hidesBottomBarWhenPushed = true
        }
    }
}

extension ShoppingVC {
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(applyFilter(_:)), name: .clickApplyButton, object: nil)
    }
    
    @objc func applyFilter(_ notification: NSNotification) {
        guard let filterCount = notification.userInfo?["count"] as? Int else { return }
        if filterCount == 0 { filterButton.setTitle("필터", for: .normal) }
        else { filterButton.setTitle("필터 (\(filterCount))", for: .normal) }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.coverBlurView.transform = .identity
            self.filteringVC.view.transform = .identity
            self.transparentView.alpha = 0
        }, completion: nil)
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
        detailViewController.hidesBottomBarWhenPushed = true
        // 선택된 Index Model 다음 뷰에 전달
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ShoppingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimateHeight = (collectionView.frame.height - 100) / 2
        let estimateWidth = (collectionView.frame.width - collectionView.frame.width / 14.2) / 2
        return CGSize(width: estimateWidth, height: estimateHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width / 14.42
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
}

extension ShoppingVC {
    private func getImageFromServer() {
        
    }
}
