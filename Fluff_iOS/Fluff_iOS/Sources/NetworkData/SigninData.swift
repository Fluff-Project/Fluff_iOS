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
    let json: JsonData
}

struct JsonData: Codable {
    let success: Bool
    let message: String
    let data: UserData?
}

struct UserData: Codable {
    let token: String
    let refreshToken: String
}
