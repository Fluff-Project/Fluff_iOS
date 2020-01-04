//
//  CheckDeliveryVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class CheckDeliveryVC: UIViewController {

    @IBOutlet weak var deliveryListTableView: UITableView!
    
    private var productImageName: [String] = ["20191218120650", "2019121870904", "20191218120650", "2019121870904", "20191218120650", "2019121870904", "20191218120650", "2019121870904", "20191218120650", "2019121870904"]
    
    private var orderDatas: [GetOrderList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deliveryListTableView.delegate = self
        deliveryListTableView.dataSource = self
        getOrderListData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "주문 / 배송 확인"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func getOrderListData() {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        OrderListService.shared.getOrderList(token: userToken) { netWorkResult in
            switch netWorkResult {
            case .success(let data):
                guard let requestData = data as? GetOrderListData else { return }
                guard let orderData = requestData.json.data else { return }
                self.orderDatas = orderData
                self.deliveryListTableView.reloadData()
            case .requestErr(let data):
                guard let requestData = data as? GetOrderListData else { return }
                self.presentAlertController(title: requestData.json.message!, message: nil)
            case .serverErr:
                self.presentAlertController(title: "서버 에러", message: nil)
            case .pathErr:
                self.presentAlertController(title: "경로 실패", message: nil)
            case .networkFail:
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다.")
            }
        }
        
    }
}

extension CheckDeliveryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let deliveryListCell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell") as? DeliveryListTableViewCell else { return UITableViewCell() }
//        guard let clotheImage = UIImage(named: productImageName[indexPath.row]) else { return UITableViewCell() }
        deliveryListCell.separatorInset = UIEdgeInsets.zero
        
        deliveryListCell.setProductNameLabel(orderDatas[indexPath.row].goodsName)
        deliveryListCell.setSellerName(orderDatas[indexPath.row].sellerName)
        deliveryListCell.setImage(orderDatas[indexPath.row].img[0])
        deliveryListCell.setPrice(orderDatas[indexPath.row].price)
        
        return deliveryListCell
    }
}

extension CheckDeliveryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 5.4864
    }
}
