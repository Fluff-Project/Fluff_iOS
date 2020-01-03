//
//  PurchaseViewController.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import BEMCheckBox

class PurchaseViewController: UIViewController {
    @IBOutlet weak var clotheImageView: UIImageView!
    @IBOutlet weak var clotheNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var nameLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabelLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameTextMarginView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contactTextMarginView: UIView!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var destinationTextMarginView: UIView!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var destinationTwoMarginView: UIView!
    @IBOutlet weak var destinationTwoTextField: UITextField!
    @IBOutlet weak var destinationThreeMarginView: UIView!
    @IBOutlet weak var destinationThreeTextField: UITextField!
    @IBOutlet weak var requestMarginView: UIView!
    @IBOutlet weak var requestTextField: UITextField!
    
    @IBOutlet weak var searchAddressButton: UIButton!
    
    @IBOutlet weak var normalAddressCheckBox: BEMCheckBox!
    
    @IBOutlet weak var totalProductPriceLabel: UILabel!
    @IBOutlet weak var totalProductPrice: UILabel!
    @IBOutlet weak var totalPaymentLabel: UILabel!
    
    @IBOutlet weak var paymentButton: UIButton!
    
    private var purchaseList: [EachCartData] = []
    private var productPrice: Int?
    private var feePrice: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setConstraint()
        setMarginView()
        setButton()
        self.view.endEditing(true)
        setInitPrice()
        setInitImageView()
        setInitNameLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNaviBackButton()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setPurchaseList(_ purchaseList: [EachCartData]) {
        self.purchaseList = purchaseList
    }
    
    private func setNaviBackButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "10"), style: .done, target: self, action:
            #selector(popView))
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setConstraint() {
        nameLabelTopConstraint.constant = clotheImageView.frame.height / 4.5
        nameLabelLeftConstraint.constant = self.view.frame.width / 34
    }
    
    private func setButton() {
        searchAddressButton.makeCornerRounded(radius: searchAddressButton.frame.width / 10)
        normalAddressCheckBox.boxType = .square
        normalAddressCheckBox.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
        normalAddressCheckBox.onCheckColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
        normalAddressCheckBox.onTintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
        normalAddressCheckBox.onAnimationType = .stroke
        normalAddressCheckBox.offAnimationType = .stroke
        paymentButton.makeCornerRounded(radius: paymentButton.frame.width / 16)
    }
    
    private func setMarginView() {
        nameTextMarginView.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        nameTextMarginView.layer.borderWidth = 1
        contactTextMarginView.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        contactTextMarginView.layer.borderWidth = 1
        destinationTextMarginView.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        destinationTextMarginView.layer.borderWidth = 1
        destinationTwoMarginView.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        destinationTwoMarginView.layer.borderWidth = 1
        destinationThreeMarginView.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        destinationThreeMarginView.layer.borderWidth = 1
        requestMarginView.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        requestMarginView.layer.borderWidth = 1
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
        self.totalProductPrice.text = formattingTotalNumber
        self.totalPaymentLabel.text = formattingTotalNumberWithDeliveryFee
    }
    
    private func setInitImageView() {
        clotheImageView.setImage(with: purchaseList[0].Img[0])
    }
    
    private func setInitNameLabel() {
        var count = -1
        for _ in purchaseList { count += 1 }
        
        if count == 0 { clotheNameLabel.text = purchaseList[0].goodsName }
        else { clotheNameLabel.text = purchaseList[0].goodsName + "외 \(count)개" }
    }
    
    @IBAction func clickPay(_ sender: Any) {
        let paymentStoryboard = UIStoryboard(name: "EndPayment", bundle: nil)
        guard let howToPayVC = paymentStoryboard.instantiateViewController(identifier: "HowToPayVC") as? HowToPayVC else { return }
        howToPayVC.hidesBottomBarWhenPushed = true
        howToPayVC.setPurchaseList(self.purchaseList)
        self.navigationController?.pushViewController(howToPayVC, animated: true)
    }
}

extension PurchaseViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
