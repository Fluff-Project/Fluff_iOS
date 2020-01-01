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
    static let tatsteAnalysis = baseURL + "/survey"
    static let recommend = baseURL + "/recommend/keyDB"
}
