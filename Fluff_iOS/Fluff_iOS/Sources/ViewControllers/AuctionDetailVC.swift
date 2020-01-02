//
//  AuctionDetailsVC.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/29.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class AuctionDetailVC: UIViewController {

    @IBOutlet weak var auctionImageCollectionView: UICollectionView!
    @IBOutlet weak var auctionDetailItemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var particicantLabel: UILabel!
    
    @IBOutlet weak var auctionItemNameLabel: UILabel!
    @IBOutlet weak var descriptionNameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var detailConfigurationLabel: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var biddingButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    private var biddingWindow: BidPopupView?
    
    var timer: Timer?
    
    let registrationTime = Date()
    lazy var deadlineTime = Date(timeInterval: 86400, since: registrationTime)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.\
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        auctionImageCollectionView.delegate = self
        auctionImageCollectionView.dataSource = self
        setNavi()
        initButton()
        initBiddingPopupView()
        addObserver()
    }
    
    @objc func onTimerFires()
    {
        let calendar = Calendar.current
        let now = Date()
        let dateGap = calendar.dateComponents([.hour,.minute,.second], from: now, to: deadlineTime)
        
        if case let (h?, m?, s?) = (dateGap.hour, dateGap.minute, dateGap.second)
        {
          timeLabel.text = String(h) + ":" + String(m) + ":" + String(s)
        } else {
            timer?.invalidate()
            timer = nil
            
        }
    }
   
    private func setNavi() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        self.setNavigationBarClear()
    }
    
    private func initButton() {
        biddingButton.makeCornerRounded(radius: biddingButton.frame.width / 20)
        biddingButton.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
        buttonView.layer.borderWidth = 0.5
        buttonView.layer.borderColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1).cgColor
    }
    
    private func initBiddingPopupView() {
        self.biddingWindow = BidPopupView()
        biddingWindow?.center = self.view.center
        let width = self.view.frame.width / 1.1916
        let height = width / 1.46
        biddingWindow?.frame.size = CGSize(width: width, height: height)
        self.view.addSubview(biddingWindow!)
        biddingWindow?.isHidden = true
    }
    
    @IBAction func showBiddingWindow(_ sender: Any) {
        biddingWindow?.center = self.view.center
        biddingWindow?.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension AuctionDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailAuctionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "auctionDetailCell", for: indexPath) as? AuctionDetailCollectionViewCell else { return UICollectionViewCell() }
        return detailAuctionCell
    }
}

extension AuctionDetailVC: UICollectionViewDelegate {
    
}

extension AuctionDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension AuctionDetailVC {
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(confirmBiddingPrice(_:)), name: .confirmBidding, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hiddenBiddingWindow), name: .clickCancelButton, object: nil)
    }
    
    @objc func confirmBiddingPrice(_ notification: NSNotification) {
        guard let biddingPrice = notification.userInfo?["price"] else { return }
        biddingWindow?.isHidden = true
        print(biddingPrice)
    }
    
    @objc func hiddenBiddingWindow() {
        biddingWindow?.isHidden = true
    }
}

