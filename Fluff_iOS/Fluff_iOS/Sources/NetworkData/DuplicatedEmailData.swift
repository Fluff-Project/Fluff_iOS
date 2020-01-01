//
//  DuplicatedEmailData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/01.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct DuplicatedEmailData: Codable {
    let code: Int
    let json: DuplicatedJsonData
}

struct DuplicatedJsonData: Codable {
    let success: Bool
    let message: String
    let data: DuplicatedInform?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(DuplicatedInform.self, forKey: .data)) ?? nil
    }
}

struct DuplicatedInform: Codable {
    let email: String
    let duplication: Bool
}
