//
//  MagazineData.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct MagazineData: Codable {
    let code: Int
    let json: MagazineJsonData
}

struct MagazineJsonData: Codable {
    let success: Bool
    let message: String
    let data: [MagazineImageData]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([MagazineImageData].self, forKey: .data)) ?? nil
    }
}

struct MagazineImageData: Codable {
    let _id, imgUrl: String
}
