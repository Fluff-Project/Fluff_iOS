//
//  UIImageView+Extensions.swift
//  InitialProject
//
//  Created by 윤동민 on 2019/12/20.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

// KingFisher 관련 사용법 확장

extension UIImageView {
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { (image, _) in // 캐시에서 키를 통해 이미지를 가져온다.
            if let image = image { // 만약 캐시에 이미지가 존재한다면
              self.image = image // 바로 이미지를 셋한다.
            } else {
                let url = URL(string: urlString) // 캐시가 없다면
                guard let realURL = url else { return }
                let resource = ImageResource(downloadURL: realURL, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                self.kf.setImage(with: resource) // 이미지를 셋한다.
            }
        }
    }
}
