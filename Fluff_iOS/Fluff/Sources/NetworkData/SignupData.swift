//
//  SignupData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/01.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct SignupData: Codable {
    let code: Int
    let json: SignupJsonData
}

struct SignupJsonData: Codable {
    let success: Bool
    let message: String
    let data: SignupUserInform?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(SignupUserInform.self, forKey: .data)) ?? nil
    }
}

struct SignupUserInform: Codable {
    let email: String
    let pwd: String
    let username: String
    let gender: String
}
