//
//  DetailInformRequestService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct DetailInformRequestService {
    static let shared = DetailInformRequestService()
    
    func requestDetailInform(token: String, goodsId: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.detailInform + goodsId, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
        
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
        case 200: return isGetDetailInform(value)
        case 400:
            print("경로에러")
            return .pathErr
        default:
            print("서버에러")
            return .serverErr
        }
    }
    
    private func isGetDetailInform(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let detailGoodsData = try? decoder.decode(DetailGoodsDataStatus.self, from: value) else { return .pathErr }
        if detailGoodsData.code == 200 { return .success(detailGoodsData) }
        else if detailGoodsData.code == 400 { return .requestErr(detailGoodsData) }
        else { return .pathErr }
    }
}
