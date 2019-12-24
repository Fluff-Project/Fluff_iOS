//
//  SignUpGenderVC.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2019/12/24.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import UIKit

class SignUpGenderVC: UIViewController {

    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func maleSelected(_ sender: Any) {
        completeButton.isEnabled = true
        guard let clickedMaleImage = UIImage(named: "maleSelected") else { return }
        maleButton.setBackgroundImage(clickedMaleImage, for: .highlighted)
    }
    
    @IBAction func femaleSelected(_ sender: Any) {
        completeButton.isEnabled = true
        guard let clickedFemaleImage = UIImage(named: "femaleSelected") else { return }
        femaleButton.setBackgroundImage(clickedFemaleImage, for: .highlighted)
        
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
