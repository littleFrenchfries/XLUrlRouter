//
//  Protocols.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/16.
//  Copyright © 2020 wangxu. All rights reserved.
//

import Foundation
public typealias RouterClosure = (Dictionary<String, Any>?) -> ()
public protocol SHClosure {
    // Mark: 用于回掉参数用的闭包
    var ll_getParams: RouterClosure? { get set }
    // Mark: 存储跳转的原始URL
    var ll_originUrl: URL? { get set }
    // Mark: URL中传的参数 或者 单独传的参数
    var ll_params: Dictionary<String, Any>? { get set }
}
