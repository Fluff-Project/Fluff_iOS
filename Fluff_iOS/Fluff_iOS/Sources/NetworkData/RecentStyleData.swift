//
//  RecentStyleData.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct RecentStyleData: Codable {
    let code: Int
    let json: RecentStyleJsonData
}

struct RecentStyleJsonData: Codable {
    let success: Bool
    let message: String
    let data: [StyleData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([StyleData].self, forKey: .data)) ?? nil
    }
}

struct StyleData: Codable {
    let mainImg: String
    let price: Int
    let _id, goodsName, sellerName, sellerId: String
    let like: Bool
}
