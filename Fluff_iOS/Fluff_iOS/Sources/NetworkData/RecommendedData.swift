//
//  RecommendedData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct RecommendedData: Codable {
    let code: Int
    let json: RecommendedJSONData
}

struct RecommendedJSONData: Codable {
    let success: Bool
    let message: String
}
