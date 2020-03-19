//
//  Router.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/13.
//  Copyright © 2020 wangxu. All rights reserved.
//
import Foundation
struct Router {
    static var configDict:Dictionary<String, Any>?
    static func loadConfigDict(pistName: String) {
        if let url = Bundle.main.url(forResource: pistName, withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
                configDict = swiftDictionary
            } catch {
                log("请按照说明添加对应的plist文件")
            }
        }
    }
    
    static func go(urlString: String, query: Dictionary<String, Any>? = nil, animated: Bool, reverseBlock: @escaping(Dictionary<String, Any>?) -> ()) {
        guard let dict = configDict else {
            log("请按照说明添加对应的plist文件")
            return
        }
        guard var vc:VCClosure = LL.currentViewController as? VCClosure else {
            log("当前控制器没有遵守VCClosure协议")
            return
        }
        vc.ll_getParams = reverseBlock
        LL.pushViewController(LL.initVC(urlString: urlString, query: query, dict: dict), animated: animated, false)
    }
    static func goBack(params: [String: Any]? = nil, animated: Bool) {
        guard let vc:VCClosure = LL.lastViewController as? VCClosure else {
            log("将要返回的控制器没有遵守VCClosure协议")
            return
        }
        if let getP = vc.ll_getParams, let _ = params {
            getP(params)
        }
        LL.popViewController(animated: animated)
    }
    static func present(urlString: String, animated: Bool, completion: (() -> Void)? = nil) {
        guard let dict = configDict else {
            log("请按照说明添加对应的plist文件")
            return
        }
        LL.presentViewController(LL.initVC(urlString: urlString, query: nil, dict: dict), animated: animated, completion: completion)
    }
}
