//
//  MenuCategory.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/25.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation

enum MenuCategory: Int, CaseIterable {
    case deliveryCheck = 0
    case reviseInformation = 1
    case tasteResetting = 2
    case logout = 3
    
    func getMenuText() -> String {
        switch self {
        case .deliveryCheck: return "주문/배송 확인"
        case .reviseInformation: return "내 정보 수정"
        case .tasteResetting: return "취향 재설정"
        case .logout: return "로그아웃"
        }
    }
}
