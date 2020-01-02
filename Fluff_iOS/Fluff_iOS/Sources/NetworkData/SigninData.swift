//
//  SigninData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/31.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation

struct SigninData: Codable {
    let code: Int
    let json: SigninJsonData
}

struct SigninJsonData: Codable {
    let success: Bool
    let message: String
    let data: SigninToken?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(SigninToken.self, forKey: .data)) ?? nil
    }
}

struct SigninToken: Codable {
    let token: String
    let refreshToken: String
    let style: Bool?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case refreshToken = "refreshToken"
        case style = "style"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = (try? values.decode(String.self, forKey: .token)) ?? ""
        refreshToken = (try? values.decode(String.self, forKey: .refreshToken)) ?? ""
        style = (try? values.decode(Bool.self, forKey: .style)) ?? nil
    }
}
