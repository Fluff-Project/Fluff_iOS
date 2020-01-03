//
//  SocketawdViewController.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import UIKit

class SocketawdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SocketService.shared.socket.on("") { dataArray, ack in
            let awd = dataArray[0] as! Int
            print(awd)
        }
            
        SocketService.shared.connect()
        
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        print(userToken)
        SocketService.shared.bid(token: userToken) { networkResult in
            switch networkResult {
            case .success(let data):
                guard let aa = data as? BIDData else { return }
                print(aa.bid)
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            default:
                print("aaaaa")
            }
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        SocketService.shared.sendMessage(nickName: "DM", message: "awdawd")
    }
}
