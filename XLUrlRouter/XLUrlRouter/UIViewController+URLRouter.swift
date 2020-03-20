//
//  UIViewController+URLRouter.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/12.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit

typealias VCClosure = UIViewController & SHClosure
extension LL where Base: UIViewController {
    
    /// 根据URL初始化控制器【概述】
    /// 根据URL初始化控制器，存储传来的参数【更详细的描述】
    ///
    /// - Parameter url: URL例如 =
    /// url = https://static.tradeaider.com/privacy-zh.html
    /// url.path = /privacy-zh.html
    /// url.scheme = https
    /// url.host = static.tradeaider.com
    /// url = tradeaider://me/setting
    /// url.path = /setting
    /// url.scheme = tradeaider
    /// url.host = me
    /// - Parameter query: 传来的参数字典
    /// - Parameter dict: 本地存储控制器的plist文件转化的字典
    /// - Returns: 需要创建的控制器
    ///
    /// - Note:供内部使用
    ///
    internal static func initVC(urlString: String, query: Dictionary<String, Any>?, dict configDict: Dictionary<String, Any>) -> Base? {
        guard let url = URL(string: urlString) else {
            log("url输入错误，可能含有中文")
            return nil
        }
        var home:String = ""
        guard let urlScheme = url.scheme else { return nil }
        guard let urlHost = url.host else { return nil }
        if url.path.isEmpty {
            home = urlScheme + "://" + urlHost
        }else {
            home = urlScheme + "://" + urlHost + url.path
        }
        var anyClass: AnyClass?
        if configDict.keys.contains(urlScheme) {
            guard let config = configDict[urlScheme] else { return nil }
            if let configStr:String = config as? String {
                anyClass = NSClassFromString(configStr)
            }else if let dict: Dictionary<String, String> = config as? Dictionary<String, String> {
                if dict.keys.contains(home) {
                    guard let homeValue = dict[home] else { return nil }
                    anyClass = NSClassFromString(homeValue)
                    if let _ = anyClass {
                    }else {
                        guard let spaceName = Bundle.main.infoDictionary?["CFBundleExecutable"] else { return nil }
                        guard let spaceNameStr = spaceName as? String else { return nil }
                        anyClass = NSClassFromString(spaceNameStr + "." + homeValue)
                    }
                }
            }
        }
        guard let vcClass = anyClass as? VCClosure.Type else {
            log("请将" + NSStringFromClass(anyClass ?? UIViewController.self) + "继承SHClosure协议")
            return nil
        }
        var vc = vcClass.init()
        vc.ll_originUrl = url
        if (query != nil) {
            vc.ll_params = query
        }else {
            vc.ll_params = url.ll.queryParameters
        }
        return vc as? Base
    }
}
