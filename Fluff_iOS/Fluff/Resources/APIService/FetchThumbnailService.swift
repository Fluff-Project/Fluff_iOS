//
//  FetchThumbnailService.swift
//  Fluff_iOS
//
//  Created by TaeJin Oh on 2020/01/01.
//  Copyright © 2020 TaeJin Oh. All rights reserved.
//

import Foundation
import Alamofire

struct FetchThumbnailService {
    static let shared = FetchThumbnailService()
    
    func fetchThumbnail (completion: @escaping (NetworkResult<Any>) -> Void) {
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        
    }
}
