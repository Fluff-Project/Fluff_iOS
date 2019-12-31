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
    case modernChic = 3
    case unique = 4
    case formal = 5
    case esnic = 6
    case sporte = 7
    case oldSchool = 8
    case hiphop = 9
    case amecazi = 10
    
    func getTagName() -> String {
        switch self {
        case .simple: return "심플"
        case .street: return "스트릿"
        case .lovely: return "러블리"
        case .modernChic: return "모던시크"
        case .unique: return "유니크"
        case .formal: return "포머"
        case .esnic: return "에스닉"
        case .sporte: return "스포티"
        case .oldSchool: return "올드스쿨"
        case .hiphop: return "힙합"
        case .amecazi: return "아메카지"
        }
    }
}
