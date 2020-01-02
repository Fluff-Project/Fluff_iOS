//
//  RecomendedClotheData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct RecommendedClotheData: Codable {
    let code: Int
    let json: RecommendedClotheJSONData
}

struct RecommendedClotheJSONData: Codable {
    let success: Bool
    let message: String
    let data: [ClotheData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([ClotheData].self, forKey: .data)) ?? nil
    }
}

struct ClotheData: Codable {
    let goodsName: String
    let mainImg: String
    let sellerName: String
    let price: Int
    let _id: String
}
