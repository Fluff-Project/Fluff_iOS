//
//  SocketService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import SocketIO

class SocketService {
    static let shared = SocketService()
    
    let manager = SocketManager(socketURL: URL(string: "http://1efb696d.ngrok.io")!, config: [.log(true), .compress])
    lazy var socket = self.manager.defaultSocket

    func connect() {
        socket.connect()
    }

    func disconnect() {
        socket.disconnect()
    }

    func sendMessage(nickName: String, message: String) {
        socket.emit("joinAuction", [
            "name" : "babo"
        ])
    }
}
