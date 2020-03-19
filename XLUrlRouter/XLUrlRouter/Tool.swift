//
//  Tool.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/11.
//  Copyright © 2020 wangxu. All rights reserved.
//

import Foundation

/// 日志打印【概述】
/// 使日志打印仅仅在Debug模式下打印【更详细的描述】
///
/// - Parameter msg: 打印信息
/// - Parameter file: 文件名称
/// - Parameter line: 所在的行数
/// - Parameter fn: 所在的方法
///
/// - Note:本功能只在Debug模式下打印，仅供测试使用【批注】
///
func log<T>(_ msg: T,
            file: NSString = #file,
            line: Int = #line,
            fn: String = #function
            ) {
    #if DEBUG
    let prefix = "\(file.lastPathComponent)_\(line)_\(fn):"
    print(prefix,msg)
    #endif
}

// Mark: - 定义Class类型
public typealias AnyClass = AnyObject.Type
