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
    
    private var cartDatas: [EachCartData] = []
    private var isSelected: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initButton()
        initNavi()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        self.navigationItem.title = "장바구니"
        setLeftButton()
        getCartList()
        
        addObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let index = cartTableView.indexPathForSelectedRow {
            cartTableView.deselectRow(at: index, animated: true)
        }
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

extension CartVC {
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedCheckbox), name: .clickCartCheckBox, object: nil)
    }

    @objc func setSelectedCheckbox(_ notification: NSNotification) {
        guard let selectedIndexPath = notification.userInfo?["index"] as? Int else { return }
        guard let isSelectCell = notification.userInfo?["isSelect"] as? Bool else { return }
        self.isSelected[selectedIndexPath] = !isSelectCell
    }
    
    private func getCartList() {
        print("awd")
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        CartService.shared.getCart(token: userToken) { networkResult in
            switch networkResult {
            case .success(let data):
                guard let cartLookupStatus = data as? CartLookupJSONData  else {
                    return }
                guard let cartData = cartLookupStatus.data else { return }
                self.cartDatas = cartData
                for _ in self.cartDatas {
                    self.isSelected.append(false)
                }
                self.cartTableView.reloadData()
            case .requestErr(let data):
                guard let cartLookupStatus = data as? CartLookupStatus else { return }
                guard let cancelMessage = cartLookupStatus.json.message else { return }
                self.presentAlertController(title: cancelMessage, message: nil)
            case .serverErr:
                self.presentAlertController(title: "서버 에러", message: nil)
            case .pathErr:
                self.presentAlertController(title: "경로 에러", message: nil)
            case .networkFail:
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다.")
            }
        }
    }
}

extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.view.layoutSubviews()
        guard let cartCell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as? CartTableViewCell else { return UITableViewCell() }
        cartCell.separatorInset = UIEdgeInsets.zero
        cartCell.setClotheImage(by: cartDatas[indexPath.row].Img[0])
        cartCell.setSellerName(cartDatas[indexPath.row].userName)
        cartCell.setClotheNameLabel(cartDatas[indexPath.row].goodsName)
        cartCell.setPriceLabel("\(cartDatas[indexPath.row].price)")
        // cart 셀 이름대로 셋팅되게 설정
        cartCell.setInitialInform(indexPath.row, isSelected[indexPath.row])
        cartCell.setCheckbox(isSelected[indexPath.row])
        return cartCell
    }
}

extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
}

