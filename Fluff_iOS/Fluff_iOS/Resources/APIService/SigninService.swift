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
            case .failure(let err):
                print("\(err.localizedDescription)")
                completion(.networkErr)
            }
        }
    }
    
    private func makeParameter(_ id: String, _ pwd: String) -> Parameters {
        return ["email": id, "pwd": pwd]
    }
}
