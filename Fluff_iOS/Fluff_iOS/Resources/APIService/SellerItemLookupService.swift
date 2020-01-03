//
//  SellerItemLookupService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct SellerItemLookupService {
    static let shared = SellerItemLookupService()
    
    func lookupOtherItem(sellerId: String, token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.otherItemLookup + sellerId, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
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
    
    private func judge(by statusCode: Int, value: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isGetOtherItem(value)
        case 400:
            print("경로에러")
            return .pathErr
        default:
            print("서버에러")
            return .serverErr
        }
    }
    
    private func isGetOtherItem(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let sellerOtherData = try? decoder.decode(SellerOtherData.self, from: value) else {
            print("path 에러")
            return .pathErr
        }
        
        print(sellerOtherData.json.message)
        if sellerOtherData.code == 200 { return .success(sellerOtherData) }
        else if sellerOtherData.code == 400 { return .requestErr(sellerOtherData) }
        else { return .serverErr }
    }
}
