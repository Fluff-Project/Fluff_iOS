//
//  CartService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct CartService {
    static let shared = CartService()
    
    func addCart(token: String, goodsItem: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.cart, method: .post, parameters: makeParameter(goodsItem), encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                if statusCode == 200 { completion(self.isSetCart(value)) }
                else if statusCode == 400 { completion(.pathErr) }
                else { completion(.serverErr) }
             case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func makeParameter(_ goodsItemId: String) -> Parameters {
        return ["cartId": goodsItemId]
    }
    
    private func isSetCart(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let cartStatusData = try? decoder.decode(CartStatusData.self, from: value) else { return .pathErr }
        if cartStatusData.code == 200 { return .success(cartStatusData) }
        else { return .requestErr(cartStatusData) }
    }
}
