//
//  FilteringData.swift
//  Fluff
//
//  Created by 윤동민 on 2020/01/04.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct FilteringData: Codable {
    let code: Int
    let json: FilteringJSONData
}

struct FilteringJSONData: Codable {
    let success: Bool
    let message: String
    let data: [FilteredData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([FilteredData].self, forKey: .data)) ?? nil
    }
}

struct FilteredData: Codable {
    let _id: String
    let goodsName: String
    let img: [String]
    let price: Int
}
