//
//  AuctionService.swift
//  Fluff
//
//  Created by 윤동민 on 2020/01/04.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct AcutionService {
    static let shared = AcutionService()
    
    func getAuctionList(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.auctionList, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResonse in
            switch dataResonse.result {
            case .success:
                guard let statusCode = dataResonse.response?.statusCode else { return }
                guard let value = dataResonse.result.value else { return }
                if statusCode == 200 {
                    completion(self.isGetAuctionList(value))
                } else {
                    completion(.pathErr)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func isGetAuctionList(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let auctionData = try? decoder.decode(AuctionData.self, from: value) else { return .pathErr }
        if auctionData.code == 200 {
            return .success(auctionData)
        } else {
            return .requestErr("조회에 실패하였습니다.")
        }
    }
}
