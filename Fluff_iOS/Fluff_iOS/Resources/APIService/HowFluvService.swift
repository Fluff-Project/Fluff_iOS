//
//  HowFluvService.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct HowFluvService {
    static let shared = HowFluvService()
    
    func howFluv(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.howFluv, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)

        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value: value)
                print("statusCode: \(statusCode)")
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func judge(by statusCode: Int, value: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return howIsFluv(value)
        case 400:
            print("경로에러")
            return .pathErr
        default:
            print("서버에러")
            return .serverErr
        }
    }
    
    private func howIsFluv(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let howFluvData = try? decoder.decode(HowFluvData.self, from: value) else {
            print("디코딩 오류")
            return .pathErr
        }
        print("여기까지 들어옴")
        if howFluvData.code == 200 { return .success(howFluvData.json) }
        else if howFluvData.code == 400 { return .requestErr(howFluvData.json) }
        else { return .serverErr }
    }
}
