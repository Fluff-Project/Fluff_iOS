//
//  GoodsThumbnailData.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/01.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct GoodsThumbnailData: Codable {
    let code: Int
    let json: GoodsThumbnailJsonData
}

struct GoodsThumbnailJsonData: Codable {
    let success: Bool
    let message: String
    let data: GoodsData?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(GoodsData.self, forKey: .data)) ?? nil
    }
}

struct GoodsData: Codable {
    let img: [String]
    let price, _id, goodsName: String
}
