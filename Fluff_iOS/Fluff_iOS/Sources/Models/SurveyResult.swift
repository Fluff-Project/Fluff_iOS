//
//  SurveyResult.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/01.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation

struct SurveyResult {
    private var surveyResultByCategory: [String: Int] = [:]
    
    init() {
        for each in HashTagCategory.allCases {
            surveyResultByCategory[each.getKeyword()] = 0
        }
    }
    
    mutating func setCount(by keyword: String, isPlus: Bool) {
        guard let currentCount = surveyResultByCategory[keyword] else { return }
        if isPlus { surveyResultByCategory.updateValue(currentCount + 1, forKey: keyword) }
        else { surveyResultByCategory.updateValue(currentCount - 1, forKey: keyword) }
    }
    
    func getSurveyResult(form: ([String: Int]) -> Void) {
        form(surveyResultByCategory)
    }
}
