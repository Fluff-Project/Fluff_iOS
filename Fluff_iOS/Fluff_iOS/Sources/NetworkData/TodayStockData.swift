//
//  TodayStockData.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct TodayStockData: Codable {
    let code: Int
    let json: TodayStockJsonData
}

struct TodayStockJsonData: Codable {
    let success: Bool
    let message: String
    let data: [StockData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([StockData].self, forKey: .data)) ?? nil
    }
}

struct StockData: Codable {
    let img: [String]
    let price: Int
    let _id, goodsName, sellerName: String
    let like: Bool
}
