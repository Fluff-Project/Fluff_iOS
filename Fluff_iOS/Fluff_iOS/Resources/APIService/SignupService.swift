//
//  SignupService.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2020/01/01.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

enum SignupBranch {
    case checkDuplicated
    case signup
}

struct SignupService {
    static let shared = SignupService()
    let header: HTTPHeaders = ["Content-Type": "application/json"]
    
    func checkDuplicated(email: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let dataRequest = Alamofire.request(APIConstants.duplicatedEmail, method: .post, parameters: makeDuplicatedEmailParameters(email), encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, branch: .checkDuplicated, value: value)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func makeDuplicatedEmailParameters(_ email: String) -> Parameters {
        return ["email": email]
    }
    
    private func judge(by statusCode: Int, branch: SignupBranch, value: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            switch branch {
            case .signup: return isSignup(value)
            case .checkDuplicated: return isDuplicated(value)
            }
        case 400:
            print("경로 에러")
            return .pathErr
        default:
            print("서버 에러")
            return .serverErr
        }
    }
    
    private func isDuplicated(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let emailData = try? decoder.decode(DuplicatedEmailData.self, from: value) else {
            print("파싱 에러")
            return .pathErr
        }
        if emailData.code == 500 { return .serverErr }
        else if emailData.code == 200 {
            guard let duplicatedInform = emailData.json.data else { return .pathErr }
            // duplicatedInform.duplication ==> true인 경우 중복된 데이터 있음 ==> 회원가입 불가
            // duplicatedInform.duplication ==> false인 경우 중복된 데이터 없음 ==> 회원가입 가능
            if duplicatedInform.duplication { return .requestErr(duplicatedInform) }
            else {
                NotificationCenter.default.post(name: .finishEmailCheck, object: nil)
                return .success(duplicatedInform)
            }
        } else { return .pathErr }
    }
    
    func signup(email: String, pwd: String, username: String, gender: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let dataRequest = Alamofire.request(APIConstants.signup, method: .post, parameters: makeSignupParameters(email, pwd, username, gender), encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.result.value else { return }
                let networkResult = self.judge(by: statusCode, branch: .signup, value: value)
                completion(networkResult)
            case .failure(let err):
                print("\(err.localizedDescription)")
                completion(.networkFail)
            }
        }
        
    }
    
    private func makeSignupParameters(_ email: String, _ pwd: String, _ username: String, _ gender: String) -> Parameters {
        return ["email": email, "pwd": pwd, "username": username, "gender": gender]
    }
    
    private func isSignup(_ value: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let signupData = try? decoder.decode(SignupData.self, from: value) else {
            print("디코딩 에러")
            return .pathErr
        }
        if signupData.code == 200 { return .success(signupData) }
        else if signupData.code == 403 { return .requestErr(signupData)}
        else if signupData.code == 500 { return .serverErr }
        return .success(value)
    }
}
