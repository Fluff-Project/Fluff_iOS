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
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initButton()
        initNavi()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        self.navigationItem.title = "장바구니"
        setLeftButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func setLeftButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "10"), style: .done, target: self, action: #selector(popView))
    }
    
    @objc func popView() {
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.view.layoutSubviews()
        guard let cartCell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as? CartTableViewCell else { return UITableViewCell() }
        return cartCell
    }
}

extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
}

