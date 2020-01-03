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
    
    func recommendPutData(surveyResult: SurveyResult, token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.recommend, method: .put, parameters: makeSurveyResultParameters(surveyResult), encoding: JSONEncoding.default, headers: header)

        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statuscCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statuscCode, value: value)
                print("statusCode: \(statuscCode)")
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func makeSurveyResultParameters(_ surveyResult: SurveyResult) -> Parameters {
        var returnParameter: Parameters = Parameters()
        surveyResult.getSurveyResult { surveyResult in
            let sortedParameter = surveyResult.sorted { $0.1 > $1.1 }
            let sortingKey = [sortedParameter[0].key, sortedParameter[1].key, sortedParameter[2].key]
            returnParameter.updateValue(sortingKey, forKey: "style")
        }
        return returnParameter
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
        guard let recommendedData = try? decoder.decode(RecommendedData.self, from: value) else {
            print("디코딩 오류")
            return .pathErr
        }
        if recommendedData.code == 200 { return .success(recommendedData.json) }
        else if recommendedData.code == 400 { return .requestErr(recommendedData.json) }
        else { return .serverErr }
    }
    
    
    func getRecommendFollowers(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        let dataRequest = Alamofire.request(APIConstants.seller, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                if statusCode == 200 {
                    let networkResult = self.isGetSeller(value)
                    completion(networkResult)
                }
                else if statusCode == 400 { completion(.pathErr) }
                else { completion(.serverErr) }
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }

    private func isGetSeller(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let followerData = try? decoder.decode(RecommededFollowerData.self, from: value) else { return .pathErr }
        
        if followerData.code == 200 { return .success(followerData) }
        else if followerData.code == 400 { return .pathErr }
        else { return .serverErr }
    }
    
    func getRecommendStyleClothe(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        let dataRequest = Alamofire.request(APIConstants.styleClothe, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                if statusCode == 200 { completion(self.loadingClotheData(value)) }
                else if statusCode == 400 { completion(.pathErr) }
                else { completion(.serverErr) }
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func loadingClotheData(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let clotheData = try? decoder.decode(RecommendedClotheData.self, from: value) else {
            print("awdawd")
            return .pathErr
        }
        if clotheData.code == 200 { return .success(clotheData.json) }
        else if clotheData.code == 500 { return .requestErr(clotheData.json) }
        else { return .pathErr }
    }
}
