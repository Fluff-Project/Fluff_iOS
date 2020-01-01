//
//  RecommendService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/01.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct RecommendService {
    static let shared = RecommendService()
    
    func recommend(surveyResult: SurveyResult, token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.recommend, method: .post, parameters: makeSurveyResultParameters(surveyResult), encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statuscCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statuscCode, value: value)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func makeSurveyResultParameters(_ surveyResult: SurveyResult) -> Parameters {
        var parameter: Parameters = Parameters()
        surveyResult.getSurveyResult { surveyResult in
            for (key, value) in surveyResult {
                parameter.updateValue(value, forKey: key)
            }
        }
        
        print(parameter)
        return parameter
    }
    
    private func judge(by statusCode: Int, value: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isRecommended(value)
        case 400:
            print("경로에러")
            return .pathErr
        default:
            print("서버에러")
            return .serverErr
        }
    }
    
    private func isRecommended(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let recommendedData = try? decoder.decode(RecommendedData.self, from: value) else { return .pathErr }
        if recommendedData.code == 200 { return .success(recommendedData.json) }
        else if recommendedData.code == 400 { return .requestErr(recommendedData.json) }
        else { return .serverErr }
    }
}
