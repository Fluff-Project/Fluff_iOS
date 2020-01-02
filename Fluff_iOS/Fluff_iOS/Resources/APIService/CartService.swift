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
    
    func addCart(cardID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        guard let userToken = UserDefaults.standard.value(forKey: "token") as? String else { return }
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-access-token": userToken]
        
        
    }
}
