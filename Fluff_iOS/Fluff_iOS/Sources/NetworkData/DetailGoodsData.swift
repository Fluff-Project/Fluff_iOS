//
//  DetailGoodsData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct DatailGoodsDataStatus: Codable {
    let code: Int
    let json: DetailGoodsJSONData
}

struct DetailGoodsJSONData: Codable {
    let success: Bool
    let message: String
    let data: DetailGoodsData?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(DetailGoodsData.self, forKey: .data)) ?? nil
    }
}

struct DetailGoodsData: Codable {
    let comment: String
    let img: [String]
    let grade: Int
    let condition: Int
    let _id: String
    let size: String
}
