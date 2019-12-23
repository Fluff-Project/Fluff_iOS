//
//  NetworkResult.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/23.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkErr
}
