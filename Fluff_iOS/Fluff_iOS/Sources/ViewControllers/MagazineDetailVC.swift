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
    
    @IBOutlet weak var topImage: UIImageView!
    let dotumPB = UIFont(name: "KoPubWorldDotumPB", size: 16)
    @IBOutlet weak var item1Name: UITextView!
    
    var whatMagazine = Int()
    var magazineImageData: [MagazineImageData] = []
    
    var item1AttributedStr = NSMutableAttributedString()
    let paragraphStyle = NSMutableParagraphStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topImage.hero.id = magazineImageData[whatMagazine]._id
        
        topImage.setImage(with: magazineImageData[whatMagazine].imgUrl)
        
        topImage.hero.modifiers = [.fade, .translate(x:0, y:-250), .rotate(x:-1.6), .scale(1.5)]
        
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [.kern: -1.44, .font: dotumPB as Any, .paragraphStyle: paragraphStyle]
        
        item1AttributedStr = NSMutableAttributedString(string: item1Name.text!)
        
        item1AttributedStr.addAttributes(attributes, range: NSRange(location: 0, length: item1Name.text.count))
        
        item1Name.attributedText = item1AttributedStr
        
        itemView.layer.shadowColor = UIColor.black.cgColor
        itemView.layer.shadowOpacity = 0.16
        itemView.layer.shadowOffset = .zero
        itemView.layer.shadowRadius = 10
        
        

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
