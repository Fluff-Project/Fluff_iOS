//
//  TasteAnalysisService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/31.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct TasteAnalysisService {
    static let shared = TasteAnalysisService()
    
    func tasteAnalysis(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.tatsteAnalysis, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value: value)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func makePapameter(_ token: String) -> Parameters {
        return ["token": token]
    }
    
    private func judge(by statusCode: Int, value: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isLoadingImage(value)
        case 400: return .pathErr
        default: return .serverErr
        }
    }
    
    private func isLoadingImage(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let clotheData = try? decoder.decode(TasteAnalysisData.self, from: value) else {
            print("디코딩 실패")
            return .pathErr
        }
        if clotheData.code == 200 {
            guard let surveyInformation = clotheData.json.data else { return .pathErr }
            return .success(surveyInformation)
        }
        else if clotheData.code == 400 { return .requestErr(clotheData) }
        return .pathErr
    }
}
