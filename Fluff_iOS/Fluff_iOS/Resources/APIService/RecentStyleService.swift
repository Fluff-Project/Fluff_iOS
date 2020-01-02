//
//  RecentStyleService.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct RecentStyleService {
    static let shared = RecentStyleService()
    
    func recentStyle(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.recentStyle, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)

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
        case 200: return isRecentStyle(value)
        case 400:
            print("경로에러")
            return .pathErr
        default:
            print("서버에러")
            return .serverErr
        }
    }
    
    private func isRecentStyle(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let recentStyleData = try? decoder.decode(RecentStyleData.self, from: value) else {
            print("디코딩 오류")
            return .pathErr
        }
        print("여기까지 들어옴")
        if recentStyleData.code == 200 { return .success(recentStyleData.json) }
        else if recentStyleData.code == 400 { return .requestErr(recentStyleData.json) }
        else { return .serverErr }
    }
}
