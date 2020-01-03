//
//  CartLookupStatus.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct CartLookupStatus: Codable {
    let code: Int
    let json: CartLookupJSONData
}

struct CartLookupJSONData: Codable {
    let success: Bool
    let message: String?
    let data: [EachCartData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? nil
        data = (try? values.decode([EachCartData].self, forKey: .data)) ?? nil
    }
}

struct EachCartData: Codable {
    let userName: String
    let Img: [String]
    let goodsId: String
    let goodsName: String
    let price: Int
}

