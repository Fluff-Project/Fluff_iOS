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
    // 유저 취향 기반 추천 상품 조회
    static let styleClothe = baseURL + "/recommend/style?page=7"
    // 디테일 옷 정보 조회 ==> 뒤에 goodsID 붙여서 요청
    static let detailInform = baseURL + "/goods/"
    // 셀러 다른 아이템 조회 ==> 뒤에 sellerID 붙여서 요청
    static let otherItemLookup = baseURL + "/goods/seller/"
    // 최종 주문 리스트 넘기기
    static let sendOrder = baseURL + "/order/goodsList"
    static let howFluv = baseURL + "/recommend/seller?page=4"
    static let todayStock = baseURL + "/goods?page=7&sort=newest"
    static let recentStyle = baseURL + "/goods?category=knit&page=5"
    static let todayTheme = baseURL + "/goods?sort=newest&page=20"
    static let recentTheme = baseURL + "/goods?category=knit"
    static let recommendTheme = baseURL + "/recommend/style"
    static let cardiganBanner = baseURL + "/goods?category=cardigan"
    static let skirtBanner = baseURL + "/goods?category=skirt"
    static let onepieceBanner = baseURL + "/goods?category=longOnepiece"
    static let coatBanner = baseURL + "/goods?category=coat"
}
