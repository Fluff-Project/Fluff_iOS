//
//  HashTag.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/31.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation

enum HashTagCategory: Int, CaseIterable {
    case simple = 0
    case street = 1
    case lovely = 2
    case modernchic = 3
    case unique = 4
    case formal = 5
    case ethnic = 6
    case sporty = 7
    case oldshcool = 8
    case hiphop = 9
    case amekaji = 10
    
    func getTagName() -> String {
        switch self {
        case .simple: return "심플"
        case .street: return "스트릿"
        case .lovely: return "러블리"
        case .modernchic: return "모던시크"
        case .unique: return "유니크"
        case .formal: return "포머"
        case .ethnic: return "에스닉"
        case .sporty: return "스포티"
        case .oldshcool: return "올드스쿨"
        case .hiphop: return "힙합"
        case .amekaji: return "아메카지"
        }
    }
    
    func getKeyword() -> String {
        switch self {
        case .simple: return "simple"
        case .street: return "street"
        case .lovely: return "lovely"
        case .modernchic: return "modernchic"
        case .unique: return "unique"
        case .formal: return "formal"
        case .ethnic: return "ethnic"
        case .sporty: return "sporty"
        case .oldshcool: return "oldschool"
        case .hiphop: return "hiphop"
        case .amekaji: return "amekaji"
        }
    }
}
