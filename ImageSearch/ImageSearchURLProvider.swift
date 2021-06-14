//
//  ImageSearchURLProvider.swift
//  ImageSearch
//
//  Created by Rayer Tung on 2021/6/14.
//  Copyright © 2021 Rayer. All rights reserved.
//

import Foundation

enum SearchProvider {
    case Google
    case Yandex
    case Bing
}

func GenerateISUrl(fromProvider provider: SearchProvider, withImgUrl imgUrl : String) -> String {
    var retUrl : String
    switch provider {
    case .Google:
        retUrl = "https://www.google.com/searchbyimage?&image_url=\(imgUrl)&safe=off"
    case .Yandex:
        retUrl = "https://yandex.com/images/search?rpt=imageview&url=\(imgUrl)"
    case .Bing:
        retUrl = "https://www.bing.com/images/search?view=detailv2&iss=sbi&form=SBIHMP&sbisrc=UrlPaste&q=imgurl:\(imgUrl)&idpbck=1&selectedindex=0&id=\(imgUrl)&mediaurl=\(imgUrl)"
    }
    return retUrl
}
