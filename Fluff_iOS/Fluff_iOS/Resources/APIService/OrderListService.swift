//
//  OrderListService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/03.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct OrderListService {
    static let shared = OrderListService()
    
    func getOrderList(token: String, orderList: [String],complection: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.sendOrder, method: .post, parameters: makeParamerters(orderList) , encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                if statusCode == 200 { complection(self.isSendOrderList(value)) }
                else if statusCode == 400 { complection(.pathErr) }
                else { complection(.serverErr) }
            case .failure(let err):
                print(err.localizedDescription)
                complection(.networkFail)
            }
        }
    }
    
    private func makeParamerters(_ orderList: [String]) -> Parameters {
        return ["orderList": orderList]
    }
    
    private func isSendOrderList(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let orderListData = try? decoder.decode(OrderListData.self, from: value) else {
            return .pathErr
        }
        if orderListData.code == 200 { return .success(orderListData) }
        else if orderListData.code == 400 { return .requestErr(orderListData) }
        else { return .pathErr }
    }
}
