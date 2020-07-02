//
//  UIViewController+URLRouter.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/12.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit

private struct StorageKey {
    static var ll_getParams = "ll_getParams"
    static var ll_originUrl = "ll_originUrl"
    static var ll_params   = "ll_params"
}

public extension LL where Base: UIViewController {
    // Mark: 用于回掉参数用的闭包
    var getParams: RouterClosure? {
        set {
            objc_setAssociatedObject(self.base, &StorageKey.ll_getParams, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self.base, &StorageKey.ll_getParams) as? RouterClosure
        }
    }
    // Mark: 存储跳转的原始URL
    var originUrl: URL? {
        set {
            objc_setAssociatedObject(self.base, &StorageKey.ll_originUrl, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self.base, &StorageKey.ll_originUrl) as? URL
        }
    }
    // Mark: URL中传的参数 或者 单独传的参数
    var params: Dictionary<String, Any>? {
        set {
            objc_setAssociatedObject(self.base, &StorageKey.ll_params, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self.base, &StorageKey.ll_params) as? Dictionary<String, Any>
        }
    }
    
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
                if let _ = anyClass {
                }else {
                    guard let spaceName = Bundle.main.infoDictionary?["CFBundleExecutable"] else { return nil }
                    guard let spaceNameStr = spaceName as? String else { return nil }
                    let spaceNameStr1 = spaceNameStr.replacingOccurrences(of: "-", with: "_")
                    anyClass = NSClassFromString(spaceNameStr1 + "." + configStr)
                }
            }else if let dict: Dictionary<String, String> = config as? Dictionary<String, String> {
                if dict.keys.contains(home) {
                    guard let homeValue = dict[home] else { return nil }
                    anyClass = NSClassFromString(homeValue)
                    if let _ = anyClass {
                    }else {
                        guard let spaceName = Bundle.main.infoDictionary?["CFBundleExecutable"] else { return nil }
                        guard let spaceNameStr = spaceName as? String else { return nil }
                        let spaceNameStr1 = spaceNameStr.replacingOccurrences(of: "-", with: "_")
                        anyClass = NSClassFromString(spaceNameStr1 + "." + homeValue)
                    }
                }
            }
        }
        guard let vcClass = anyClass as? UIViewController.Type else {
            log("确定" + NSStringFromClass(anyClass ?? UIViewController.self) + "是UIViewController？")
            return nil
        }
        var vc = vcClass.init()
        vc.ll.originUrl = url
        if (query != nil) {
            vc.ll.params = query
        }else {
            vc.ll.params = url.ll.queryParameters
        }
        return vc as? Base
    }
}
