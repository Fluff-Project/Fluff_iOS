//
//  AuctionDetailVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/27.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class AuctionDetailVC: UIViewController {

    @IBOutlet weak var biddingButton: UIButton!
    @IBOutlet weak var clotheNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var apllicantLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionNameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var auctionDetailScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialNavi()
        initButton()
        auctionDetailScrollView.delegate = self
    }
    
    private func initialNavi() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.setNavigationBarClear()
    }
    
    private func initButton() {
        biddingButton.makeCornerRounded(radius: biddingButton.frame.width / 13)
    }
}

extension AuctionDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 || scrollView.contentOffset.x < 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
