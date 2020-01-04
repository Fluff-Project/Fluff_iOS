//
//  FilteringService.swift
//  Fluff
//
//  Created by 윤동민 on 2020/01/04.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct FilteringService {
    static let shared = FilteringService()
    
    func filterData(token: String, color: String, category: [String], size: [String] ,completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
        
        let dataRequest = Alamofire.request(APIConstants.filering, method: .post, parameters: makeParameter(color, category, size), encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                if statusCode == 200 { completion(self.isFilter(value)) }
                else if statusCode == 400 { completion(.serverErr) }
                else { completion(.pathErr) }
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func makeParameter(_ color: String, _ category: [String], _ size: [String]) -> Parameters {
        return ["color": color, "category": category, "size": size]
    }
    
    private func isFilter(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let filterStatus = try? decoder.decode(FilteringData.self, from: value) else { return .pathErr }
        if filterStatus.code == 200 {
            guard let filteredData = filterStatus.json.data else { return .requestErr(filterStatus.json.message) }
            return .success(filterStatus.json)
        } else {
            return .serverErr
        }
    }
}
