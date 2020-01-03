//
//  CartData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct CartStatusData: Codable {
    let code: Int
    let json: CartJSONData
}

struct CartJSONData: Codable {
    let success: Bool
    let message: String
    let data: [CartData]?
}

struct CartData: Codable {
    let _id: String
}
