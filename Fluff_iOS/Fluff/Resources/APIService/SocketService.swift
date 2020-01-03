//
//  SocketService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import SocketIO
import Alamofire

struct BIDData: Codable {
    let bid: Int
}


class SocketService {
    static let shared = SocketService()
    
    let manager = SocketManager(socketURL: URL(string: "http://f3c61e12.ngrok.io?auctionId=5e0e260d3c493169d01b9bfb")!, config: [.log(true), .compress])
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
    
    func bid(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.auctionBidding, method: .post, parameters: ["bid": 500000], encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                
                if statusCode == 200 {
                    let decoder = JSONDecoder()
                    completion(self.getNetworkResult(value: value))
                }
                else if statusCode == 400 { completion(.pathErr) }
                else { completion(.serverErr) }
                
            case .failure(let err):
                completion(.networkFail)
            }
        }
    }
    
    
    private func getNetworkResult(value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodingData = try? decoder.decode(BIDData.self, from: value) else { return .pathErr }
        return .success(decodingData)
        
    }
 }
