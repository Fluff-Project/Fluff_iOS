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
    
    let numberFormatter = NumberFormatter()
    var customerName = String()
    var customerAddress = String()
    var price = Int()
    var deliveryFee = Int()
    var sum = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        price = 5700
        deliveryFee = 2300
        sum = price + deliveryFee
        
        numberFormatter.numberStyle = .decimal
        
        addressLabel.lineBreakMode = .byWordWrapping
        addressLabel.numberOfLines = 2
        confirmButton.makeCornerRounded(radius: 24)
        
        priceLabel.text = numberFormatter.string(from: NSNumber(value: price))! + "원"
        deliveryFeeLabel.text = numberFormatter.string(from: NSNumber(value: deliveryFee))! + "원"
        sumLabel.text = numberFormatter.string(from: NSNumber(value: sum))! + "원"
        checkbox.isUserInteractionEnabled = false
        initialAnimate()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func check(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
