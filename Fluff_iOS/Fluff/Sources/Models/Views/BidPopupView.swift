//
//  BidPopupView.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import UIKit

class BidPopupView: UIView {
    
    @IBOutlet weak var biddingLabel: UILabel!
    @IBOutlet weak var textBackgroundView: UIView!
    @IBOutlet weak var bidTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = Bundle.main.loadNibNamed("BidPopupView", owner: self, options: nil)?.first as? UIView else { return }
        view.frame = self.bounds
        initFont()
        initButton()
        textBackgroundView.layer.borderColor = UIColor.black.cgColor
        textBackgroundView.layer.borderWidth = 1
        self.addSubview(view)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = Bundle.main.loadNibNamed("BidPopupView", owner: self, options: nil)?.first as? UIView else { return }
        view.frame = self.bounds
        initFont()
        initButton()
        textBackgroundView.layer.borderColor = UIColor.black.cgColor
        textBackgroundView.layer.borderWidth = 1
        self.addSubview(view)
    }
    
    private func initFont() {
        biddingLabel.attributedText = NSMutableAttributedString(string: "입찰하기", attributes: [
            .font: UIFont(name: "KoPubWorldDotumPM", size: 16.0)!,
          .foregroundColor: UIColor.black,
          NSAttributedString.Key.kern: CGFloat(-0.64)
        ])
    }
    
    private func initButton() {
        confirmButton.makeCornerRounded(radius: confirmButton.frame.width / 7.4)
        confirmButton.clipsToBounds = true
    }
    
    @IBAction func clickConfirmButton(_ sender: Any) {
        guard let textPrice = bidTextField.text else { return }
        NotificationCenter.default.post(name: .confirmBidding, object: nil, userInfo: ["price": textPrice])
    }
    
    @IBAction func clickCancelButton(_ sender: Any) {
        bidTextField.text = ""
        NotificationCenter.default.post(name: .clickCancelButton, object: nil, userInfo: nil)
    }
}
