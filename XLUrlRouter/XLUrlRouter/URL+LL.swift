//
//  String+LL.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/13.
//  Copyright © 2020 wangxu. All rights reserved.
//

import Foundation

extension URL: LLCompatible { }
extension LL where Base == URL {
    var queryParameters: [String : String] {
        var dic = [String: String]();
        
        guard let queryStr = self.base.query else {
            return [:]
        }
        let queryArray = (queryStr.components(separatedBy: "&")) as Array<String>
        
        for index in 0 ..< queryArray.count {
            let queryComponent = queryArray[index]
            let compArr = queryComponent.components(separatedBy: "=") as Array<String>
            if compArr.count >= 2 {
                let key = compArr[0]
                let val = compArr[1].removingPercentEncoding
                dic.updateValue(val ?? "", forKey: key)
            }
        }
        return dic
    }
    var home: String? {
        var home:String = ""
        guard let urlScheme = self.base.scheme else { return nil }
        guard let urlHost = self.base.host else { return nil }
        if self.base.path.isEmpty {
            home = urlScheme + "://" + urlHost
        }else {
            home = urlScheme + "://" + urlHost + self.base.path
        }
        return home
    }
    
}
