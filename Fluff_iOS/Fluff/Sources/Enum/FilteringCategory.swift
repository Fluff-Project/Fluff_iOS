//
//  FilteringCategory.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/28.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation

enum FilteringCategory: Int, CaseIterable {
    case outer = 0
    case top = 1
    case pant = 2
    case skirt = 3
    case onepiece = 4
    case accessories = 5
    
    func getNotSelectImageName() -> String {
        switch self {
        case .outer: return "outerIc"
        case .top: return "topIc"
        case .pant: return "bottomIc"
        case .skirt: return "skirtsIc"
        case .onepiece: return "dressIc"
        case .accessories: return "itemsIc"
        }
    }
    
    func getSelctImageName() -> String {
        switch self {
        case .outer: return "outerSelcectedIc"
        case .top: return "topSelcectedIc"
        case .pant: return "bottomSelcectedIc"
        case .skirt: return "skirtsSelcectedIc"
        case .onepiece: return "dressSelcectedIc"
        case .accessories: return "itemsSelcectedIc"
        }
    }
    
    func getCategoryName() -> String {
        switch self {
        case .outer: return "아우터"
        case .top: return "상의"
        case .pant: return "바지"
        case .skirt: return "스커트"
        case .onepiece: return "원피스"
        case .accessories: return "패션 잡화"
        }
    }
    
    func getDetailFilter() -> [String] {
        switch self {
        case .outer: return ["자켓", "가디건", "점퍼", "야상", "베스트", "코트", "패딩"]
        case .top: return ["티셔츠", "니트", "셔츠", "맨투맨", "후드", "블라우스"]
        case .pant: return ["반바지", "일자바지", "와이드팬츠", "스키니", "멜빵바지"]
        case .skirt: return ["미니스커트", "롱스커트"]
        case .onepiece: return ["미니원피스", "롱원피스", "투피스"]
        case .accessories: return ["가방", "장갑(워머)", "목도리", "숄"]
        }
    }
}
