//
//  FluvApplyVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/31.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class FluvApplyVC: UIViewController {

    @IBOutlet weak var storenameLabel: UILabel!
    @IBOutlet weak var oneLineIntroduceLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var keywordOneButton: UIButton!
    @IBOutlet weak var keywordTwoButton: UIButton!
    
    @IBOutlet weak var storeDescriptionLabel: UILabel!
    
    @IBOutlet weak var storeIntroduceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var updateDayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNaviBackButton()
        setFont()
        setButtons()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.setNavigationBarClear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setFont() {
        storenameLabel.attributedText = NSMutableAttributedString(string: "가게 이름", attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 14)!, .foregroundColor: UIColor.black, NSAttributedString.Key.kern: CGFloat(-0.42)])
        oneLineIntroduceLabel.attributedText = NSMutableAttributedString(string: "한 줄 소개", attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 14)!, .foregroundColor: UIColor.black, NSAttributedString.Key.kern: CGFloat(-0.42)])
        keywordLabel.attributedText = NSMutableAttributedString(string: "키워드", attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 14)!, .foregroundColor: UIColor.black, NSAttributedString.Key.kern: CGFloat(-0.42)])
        keywordOneButton.titleLabel?.attributedText = NSMutableAttributedString(string: "#키워드설정", attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 11)!, .foregroundColor: UIColor.black, NSAttributedString.Key.kern: -0.44])
        keywordTwoButton.titleLabel?.attributedText = NSMutableAttributedString(string: "#키워드설정", attributes: [.font: UIFont(name: "KoPubWorldDotumPM", size: 11)!, .foregroundColor: UIColor.black, NSAttributedString.Key.kern: -0.44])
        storeDescriptionLabel.attributedText = NSMutableAttributedString(string: "가게 설명", attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 14)!, .foregroundColor: UIColor.black, NSAttributedString.Key.kern: CGFloat(-0.42)])
        storeIntroduceLabel.attributedText = NSMutableAttributedString(string: "가게 소개", attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 14)!, .foregroundColor: UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0), NSAttributedString.Key.kern: CGFloat(-0.42)])
        changeLabel.attributedText = NSMutableAttributedString(string: "교환/환불 여부", attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 14)!, .foregroundColor: UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1), NSAttributedString.Key.kern: CGFloat(-0.42)])
        deliveryLabel.attributedText = NSMutableAttributedString(string: "배송 관련", attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 14)!, .foregroundColor: UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1), NSAttributedString.Key.kern: CGFloat(-0.42)])
        updateDayLabel.attributedText = NSMutableAttributedString(string: "배송 관련", attributes: [.font: UIFont(name: "KoPubWorldDotumPB", size: 14)!, .foregroundColor: UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1), NSAttributedString.Key.kern: CGFloat(-0.42)])
    }
    
    private func setNaviBackButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "10"), style: .done, target: self, action: #selector(popView))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(completeApply))
    }
    
    private func setButtons() {
        keywordOneButton.layer.borderColor = UIColor.black.cgColor
        keywordOneButton.layer.borderWidth = 1
        keywordOneButton.makeCornerRounded(radius: keywordOneButton.frame.width / 6)
        keywordOneButton.clipsToBounds = true
        keywordTwoButton.layer.borderColor = UIColor.black.cgColor
        keywordTwoButton.makeCornerRounded(radius: keywordTwoButton.frame.width / 6)
        keywordTwoButton.layer.borderWidth = 1
        keywordTwoButton.clipsToBounds = true
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func completeApply() {
        print("complete")
    }
}
