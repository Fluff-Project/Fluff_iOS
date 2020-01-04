//
//  GetOrderListDat.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct GetOrderListData: Codable {
    let code: Int
    let json: GetOrderListJSONData
}

struct GetOrderListJSONData: Codable {
    let success: Bool
    let message: String?
    let data: [GetOrderList]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? nil
        data = (try? values.decode([GetOrderList].self, forKey: .data)) ?? nil
    }
}

struct GetOrderList: Codable {
    let img: [String]
    let price: Int
    let _id: String
    let goodsName: String
    let sellerName: String
}
