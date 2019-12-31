//
//  SigninService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/31.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct SigninService {
    static let shared = SigninService()
    
    func signin(email: String, pwd: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json"]
    
        let dataRequest = Alamofire.request(APIConstants.signin, method: .post, parameters: makeParameter(email, pwd), encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                print(statusCode)
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value: value)
                completion(networkResult)
            case .failure(let err):
                print("\(err.localizedDescription)")
                completion(.networkFail)
            }
        }
    }
    
    private func makeParameter(_ id: String, _ pwd: String) -> Parameters {
        return ["email": id, "pwd": pwd]
    }
    
    private func judge(by statusCode: Int, value: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            print("200코드")
            return isUser(value)
        case 400:
            print("400코드")
            return .pathErr
        default: return .serverErr
        }
    }
    
    private func isUser(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
//        guard let signinData = try? decoder.decode(SigninData.self, from: value) else { return .pathErr }
//        print("Decoding Code :\(signinData.code)")
//        if signinData.code == 200 {
//            return .success(signinData)
//        } else if signinData.code == 400 {
//            return .requestErr(signinData)
//        }
        return .pathErr
    }
}
