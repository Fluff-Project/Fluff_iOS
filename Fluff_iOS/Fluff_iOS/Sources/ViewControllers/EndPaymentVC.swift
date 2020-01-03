//
//  EndPaymentVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/30.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import BEMCheckBox

class EndPaymentVC: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var checkbox: BEMCheckBox!
    @IBOutlet weak var fistDashedLine: UIView!
    @IBOutlet weak var secondDashedLine: UIView!
    @IBOutlet weak var thirdDashedLine: UIView!
    
    private var purchaseList: [EachCartData] = []
    let numberFormatter = NumberFormatter()
    var customerName = String()
    var customerAddress = String()
    var price = Int()
    var deliveryFee = Int()
    var sum = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        sum = price + deliveryFee
        deliveryFee = 2500
        
        numberFormatter.numberStyle = .decimal
        
        addressLabel.lineBreakMode = .byWordWrapping
        addressLabel.numberOfLines = 2
        confirmButton.makeCornerRounded(radius: 24)
        
        priceLabel.text = numberFormatter.string(from: NSNumber(value: price))! + "원"
        deliveryFeeLabel.text = numberFormatter.string(from: NSNumber(value: deliveryFee))! + "원"
        sumLabel.text = numberFormatter.string(from: NSNumber(value: sum))! + "원"
        checkbox.isUserInteractionEnabled = false
        initialAnimate()
        setInitPrice()
    }
    
    private func initialAnimate() {
        backgroundView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        confirmButton.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.backgroundView.transform = .identity
        }, completion: { isAnimate in
            self.checkbox.onAnimationType = .stroke
            self.checkbox.setOn(true, animated: true)
        })
        
        UIView.animate(withDuration: 1, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.confirmButton.transform = .identity
        }, completion: nil)
    }
    
    func setPurchaseList(_ purchaseList: [EachCartData]) {
        self.purchaseList = purchaseList
    }
    
    private func setInitPrice() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var totalPrice: Int = 0
        for eachData in self.purchaseList {
            totalPrice += eachData.price
        }
        
        let formattingTotalNumber = numberFormatter.string(from: NSNumber(value: totalPrice)) ?? "0"
        totalPrice += 2500
        let formattingTotalNumberWithDeliveryFee = numberFormatter.string(from: NSNumber(value: totalPrice)) ?? "0"
        self.priceLabel.text = formattingTotalNumber
        sumLabel.text = formattingTotalNumberWithDeliveryFee
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func check(_ sender: Any) {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        var goodsIds: [String] = []
        for purchase in purchaseList {
            goodsIds.append(purchase.goodsId)
        }
        
        OrderListService.shared.getOrderList(token: userToken, orderList: goodsIds) { networkResult in
            switch networkResult {
            case .success(let data):
                guard let orderListData = data as? OrderListData else { return }
                print(orderListData)
                self.navigationController?.popToRootViewController(animated: true)
            case .requestErr(let data):
                self.presentAlertController(title: "배송 주문 조회 실패", message: nil)
            case .serverErr:
                self.presentAlertController(title: "서버 에러", message: nil)
            case .pathErr:
                self.presentAlertController(title: "경로 에러", message: nil)
            case .networkFail:
                self.presentAlertController(title: "네트워크 연결 실패", message: "네트워크 연결이 필요합니다.")
            }
        }
        
//        self.navigationController?.popToRootViewController(animated: true)
        
    }
}
