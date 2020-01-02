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
        SocketService.shared.socket.on("joinAuction") { dataArray, ack in
                print(dataArray)
        }
            
        SocketService.shared.connect()
        
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        SocketService.shared.sendMessage(nickName: "DM", message: "awdawd")
    }
}
