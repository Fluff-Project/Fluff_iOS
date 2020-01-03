//
//  OrderListData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct OrderListData: Codable {
    let code: Int
    let json: OrderListDataJSON
}

struct OrderListDataJSON: Codable {
    let success: Bool
    let data: [OrderData]?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? nil
        data = (try? values.decode([OrderData].self, forKey: .data)) ?? nil
    }
}

struct OrderData: Codable {
    let _id: String
}
