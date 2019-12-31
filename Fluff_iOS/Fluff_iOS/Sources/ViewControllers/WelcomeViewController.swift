//
//  WelcomeViewController.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/30.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var oneBackgroundView: UIImageView!
    @IBOutlet weak var twoBackgroundView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setFont()
        setButton()
        self.transparentView.alpha = 0.8
        UIView.animate(withDuration: 0.5, animations: {
            self.transparentView.alpha = 0.35
        }, completion: nil)
        
        oneBackgroundView.transform = CGAffineTransform(translationX: 300, y: 0)
        twoBackgroundView.transform = CGAffineTransform(translationX: -300, y: 0)
        initAnimtaion()
    }
    
    private func initAnimtaion() {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.oneBackgroundView.transform = .identity
            self.twoBackgroundView.transform = .identity
        }, completion: nil)
    }
    
    private func setButton() {
        startButton.makeCornerRounded(radius: startButton.frame.width / 13.666)
        startButton.clipsToBounds = true
    }
    
    private func setFont() {
        let attributedString = NSMutableAttributedString(string: "오직 당신을 위한 빈티지 플랫폼", attributes: [
          .font: UIFont(name: "KoPubWorldDotumPL", size: 19.0)!,
          .foregroundColor: UIColor.white
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "KoPubWorldDotumPB", size: 19.0)!, range: NSRange(location: 10, length: 7))
        
        welcomeLabel.attributedText = attributedString
                
        let buttonAttributedText = NSMutableAttributedString(string: "플러프 시작하기", attributes: [
          .font: UIFont(name: "KoPubWorldDotumPB", size: 16.0)!,
          .foregroundColor: UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
        ])
        startButton.setAttributedTitle(buttonAttributedText, for: .normal)
    }
    
    @IBAction func clickStartButton(_ sender: Any) {
        guard let mainTabbarVC = self.storyboard?.instantiateViewController(identifier: "MainTabbarController") as? MainTabbarController else { return }
        mainTabbarVC.modalPresentationStyle = .fullScreen
        self.present(mainTabbarVC, animated: true, completion: nil)
    }
}
