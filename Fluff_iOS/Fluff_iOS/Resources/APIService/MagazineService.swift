//
//  MagazineService.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/02.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct MagazineService {
    static let shared = MagazineService()
    
    func getMagazine(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        print("HI")
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": token]
    


        let dataRequest = Alamofire.request(APIConstants.magazine, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, value: value)
                completion(networkResult)
            case .failure(let err):
                print("\(err.localizedDescription)")
                completion(.networkFail)
            }
        }
    }
    
    private func judge(by statusCode: Int, value: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isLoadingImage(value)
        case 400:
            print("400번대 오류")
            return .pathErr
        default: return .serverErr
        }
    }
    
    private func isLoadingImage(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let magazineData = try? decoder.decode(MagazineData.self, from: value) else {
            print("디코딩 실패")
            return .pathErr
        }
        if magazineData.code == 200 {
            guard let magazineJson = magazineData.json else { return .pathErr }
            return .success(magazineJson)
        }
        else if magazineData.code == 400 { return .requestErr(magazineData.json!) }
        return .pathErr
    }
}
