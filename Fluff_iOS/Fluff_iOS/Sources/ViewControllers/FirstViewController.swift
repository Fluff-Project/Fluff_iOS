//
//  FirstViewController.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import UIKit
import Hero

class FirstViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        firstImage.hero.id = "bts"
        
        
        firstImage.hero.modifiers = [.fade, .translate(x:0, y:-250), .rotate(x:-1.6), .scale(1.5)]

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
