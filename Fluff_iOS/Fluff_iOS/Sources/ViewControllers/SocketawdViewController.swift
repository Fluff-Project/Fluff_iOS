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
        SocketService.shared.socket.on("?auctionId=5e0e260d3c493169d01b9bfb&token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTBhNDE2ZjIxN2YyMjAwMTE5YjYwMzciLCJ1c2VybmFtZSI6IuyekOydvOuPmeyDneyLoOydvCIsImVtYWlsIjoicGxhbkBzb3B0Lm9yZyIsImlhdCI6MTU3ODA1NzE4NCwiZXhwIjoxNTc4MjAxMTg0LCJpc3MiOiJvb2V1bnoifQ.nvPg08tdbiG726RN-J0TNRQaVVJNZEXztKETCtG-8wQ") { dataArray, ack in
                print(dataArray)
        }
            
        SocketService.shared.connect()
        
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        SocketService.shared.sendMessage(nickName: "DM", message: "awdawd")
    }
}
