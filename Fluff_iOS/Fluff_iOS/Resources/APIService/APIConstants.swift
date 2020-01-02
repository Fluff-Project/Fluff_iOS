//
//  APIConstants.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/23.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation

struct APIConstants {
    static let baseURL = "http://3.212.182.137:3000"
    static let signin = baseURL + "/auth/login"
    // 회원가입 전 email 중복확인 체크
    static let duplicatedEmail = baseURL + "/auth/checkEmail"
    // 회원가입 정보들 총 종합 확인하는 주소
    static let signup = baseURL + "/auth/directSignUp"
    // tasteAnalysis 사진 데이터 받아오기
    static let tatsteAnalysis = baseURL + "/survey"
    // 선택한 사진 바탕으로 추천 알고리즘 요청
    static let recommend = baseURL + "/recommend/keyDB"
    static let cart = baseURL + "/cart"
    static let magazine = baseURL + "/magazine"
    // 추천 셀러 받아오는 주소
    static let seller = baseURL + "/recommend/seller?page=1"
}
