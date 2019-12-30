//
//  EndPaymentVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/30.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class EndPaymentVC: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    let numberFormatter = NumberFormatter()
    var customerName = String()
    var customerAddress = String()
    var price = Int()
    var deliveryFee = Int()
    var sum = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
