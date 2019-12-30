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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deliveryListTableView.delegate = self
        deliveryListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "주문 / 배송 확인"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension CheckDeliveryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let deliveryListCell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell") as? DeliveryListTableViewCell else { return UITableViewCell() }
        guard let clotheImage = UIImage(named: productImageName[indexPath.row]) else { return UITableViewCell() }
        deliveryListCell.separatorInset = UIEdgeInsets.zero
        deliveryListCell.deliveryProductImage.image = clotheImage
        return deliveryListCell
    }
}

extension CheckDeliveryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 5.4864
    }
}
