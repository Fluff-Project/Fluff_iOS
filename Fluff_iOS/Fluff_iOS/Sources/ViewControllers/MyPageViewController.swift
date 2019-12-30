//
//  MyPageViewController.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var nameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentProductViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var currentProductCollectionView: UICollectionView!
    @IBOutlet weak var myPageButtonTableView: UITableView!
    
    @IBOutlet weak var makeShopButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setInitConstraint()
        initialNavi()
        setInitTableView()
        setInitButton()
        currentProductCollectionView.delegate = self
        currentProductCollectionView.dataSource = self
        myPageButtonTableView.dataSource = self
        myPageButtonTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarClear()
        if tabBarController!.tabBar.isHidden {
            bottomConstraint.constant = self.tabBarController!.tabBar.frame.height
//            self.view.setNeedsLayout()
        }
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setInitButton() {
        makeShopButton.makeCornerRounded(radius: makeShopButton.frame.width / 10)
        makeShopButton.makeShadow(opacity: 0.4, radius: 7)
    }
    
    private func setInitTableView() {
        myPageButtonTableView.layer.borderColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 0.51).cgColor
        myPageButtonTableView.layer.borderWidth = 0.5
    }
    
    private func setInitConstraint() {
        nameTopConstraint.constant = self.view.bounds.height / 10.41
        currentProductViewTopConstraint.constant = self.view.bounds.height / 19.804
    }
    
    private func initialNavi() {
        self.navigationController?.navigationBar.tintColor = UIColor(red: 58/255, green: 64/255, blue: 71/255, alpha: 1.0)
    }
    
    @IBAction func goLikeListView(_ sender: Any) {
        guard let likeListVC = self.storyboard?.instantiateViewController(identifier: "LikeListParentVC") as? LikeListParentVC else { return }
        likeListVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(likeListVC, animated: true)
    }
}

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let currentProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentProductCell", for: indexPath) as? CurrentProductCollectionViewCell else { return UICollectionViewCell() }
        
        
        return currentProductCell
    }
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: collectionView.frame.height)
    }
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let myPageCell = tableView.dequeueReusableCell(withIdentifier: "myPageButtonCell") as? MyPageTableViewCell else { return UITableViewCell() }
        myPageCell.separatorInset = UIEdgeInsets.zero
        myPageCell.layer.borderColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 0.51).cgColor
        
        guard let menu = MenuCategory(rawValue: indexPath.row) else { return UITableViewCell() }
        myPageCell.setMenuText(menu.getMenuText())
        return myPageCell
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedMenu = MenuCategory(rawValue: indexPath.row) else { return }
        switch selectedMenu {
        case .deliveryCheck:
            let checkStoryboard = UIStoryboard(name: "checkDelivery", bundle: nil)
            guard let deliveryVC = checkStoryboard.instantiateViewController(identifier: "checkDeliveryVC") as? CheckDeliveryVC else { return }
            deliveryVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(deliveryVC, animated: true)
        case .reviseInformation: return
        case .tasteResetting:
            guard let tasteAnalysis = self.storyboard?.instantiateViewController(identifier: "TasteAnalysisVC") as? TasteAnalysisVC else { return }
            tasteAnalysis.setAnalysisStatus(.resetting)
            tasteAnalysis.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(tasteAnalysis, animated: true)
        case .logout: return
            
        
        }
    }
}
