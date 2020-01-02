//
//  RecommededFollowerData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct RecommededFollowerData: Codable {
    let code: Int
    let json: RecommendedJsonData
}

struct RecommendedJsonData: Codable {
    let success: Bool
    let message: String
    let data: [SellerData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([SellerData].self, forKey: .data)) ?? nil
    }
}

struct SellerData: Codable {
    let sellerId: String
    let sellerName: String
    let sellerImg: String
    let img: [String]
}
