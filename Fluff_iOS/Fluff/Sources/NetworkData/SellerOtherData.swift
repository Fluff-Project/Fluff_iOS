//
//  SellerOtherData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct SellerOtherData: Codable {
    let code: Int
    let json: SellerOtherJSONData
}

struct SellerOtherJSONData: Codable {
    let success: Bool
    let message: String
    let data: [OtherItemData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([OtherItemData].self, forKey: .data)) ?? nil
    }
}

struct OtherItemData: Codable {
    let _id: String
    let goodsName: String
    let mainImg: String
    let price: Int
}
