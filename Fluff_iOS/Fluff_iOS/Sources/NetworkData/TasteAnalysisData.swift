//
//  TasteAnalysisData.swift
//  Fluff_iOS
//
//  Created by 윤동민 on 2019/12/31.
//  Copyright © 2019 TaeJin Oh. All rights reserved.
//

import Foundation

struct TasteAnalysisData: Codable {
    let code: Int
    let json: TasteAnalysisJsonData
}

struct TasteAnalysisJsonData: Codable {
    let success: Bool
    let message: String
    let data: ServeyInfotmation?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(ServeyInfotmation.self, forKey: .data))
    }
}

struct ServeyInfotmation: Codable {
    let _id: String
    let serveyVersion: String
    let serveyList: [ClotheInformation]
}

struct ClotheInformation: Codable {
    let style: [String]
    let _id: String
    let img: String
}
