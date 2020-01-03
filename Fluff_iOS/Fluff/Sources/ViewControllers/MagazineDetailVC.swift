//
//  MagazineDetailVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/31.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit
import Hero

class MagazineDetailVC: UIViewController {

    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var item1Name: UITextView!
    
    let dotumPB = UIFont(name: "KoPubWorldDotumPB", size: 16)
    
    var whatMagazine = Int()
    var magazineImageData: [MagazineImageData] = []
    
    var title1Str = "옷만큼 개성있는"
    var title2Str = "오프라인 빈티지 매장들"
    
    var item1AttributedStr = NSMutableAttributedString()
    let paragraphStyle = NSMutableParagraphStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topImage.hero.id = magazineImageData[whatMagazine]._id
        
        topImage.setImage(with: magazineImageData[whatMagazine].imgUrl)
        
        topImage.hero.modifiers = [.fade, .translate(x:0, y:-250), .rotate(x:-1.6), .scale(1.5)]
        
        title1Label.text = title1Str
        title2Label.text = title2Str
        
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [.kern: -1.44, .font: dotumPB as Any, .paragraphStyle: paragraphStyle]
        
        item1AttributedStr = NSMutableAttributedString(string: item1Name.text!)
        
        item1AttributedStr.addAttributes(attributes, range: NSRange(location: 0, length: item1Name.text.count))
        
        item1Name.attributedText = item1AttributedStr
        
        itemView.layer.shadowColor = UIColor.black.cgColor
        itemView.layer.shadowOpacity = 0.16
        itemView.layer.shadowOffset = .zero
        itemView.layer.shadowRadius = 10
    }
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            let translation = sender.translation(in: nil)
            let progress = translation.y / 2 / view.bounds.height
            Hero.shared.update(progress)
        default:
            Hero.shared.finish()
            
        }
    }
}
