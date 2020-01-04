//
//  AuctionData.swift
//  Fluff
//
//  Created by 윤동민 on 2020/01/04.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct AuctionData: Codable {
    let code: Int
    let json: AuctionJSONData
}

struct AuctionJSONData: Codable {
    let success: Bool
    let message: String
    let data: [AuctionRealData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([AuctionRealData].self, forKey: .data)) ?? nil
    }
}

struct AuctionRealData: Codable {
    let mainImg: String
    let auctionName: String
    let bid: Int
    let _id: String
    let size: String
    let condition: Int
    let comment: String
}
