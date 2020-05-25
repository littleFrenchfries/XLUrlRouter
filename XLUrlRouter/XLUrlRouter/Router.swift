//
//  Router.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/13.
//  Copyright © 2020 wangxu. All rights reserved.
//
import Foundation
public struct Router {
    public static var configDict:Dictionary<String, Any>?
    public static func loadConfigDict(pistName: String) {
        if pistName.hasSuffix(".plist") {
            if let url = Bundle.main.url(forResource: pistName, withExtension: nil) {
                do {
                    let data = try Data(contentsOf: url)
                    let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
                    configDict = swiftDictionary
                } catch {
                    log("请按照说明添加对应的plist文件")
                }
            }
        }else if let url = Bundle.main.url(forResource: pistName, withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let swiftDictionary = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
                configDict = swiftDictionary
            } catch {
                log("请按照说明添加对应的plist文件")
            }
        }
    }
    
    public static func go(urlString: String, query: Dictionary<String, Any>? = nil, animated: Bool, reverseBlock: ((Dictionary<String, Any>?) -> ())? = nil) {
        guard let dict = configDict else {
            log("请按照说明添加对应的plist文件")
            return
        }
        if var vc = LL.currentViewController {
            vc.ll.getParams = reverseBlock
        }
        LL.pushViewController(LL.initVC(urlString: urlString, query: query, dict: dict), animated: animated, false)
    }
    public static func goBack(params: [String: Any]? = nil, animated: Bool) {
        guard let vc = LL.lastViewController else {
            log("将要返回的控制器不存在")
            return
        }
        if let getP = vc.ll.getParams, let _ = params {
            getP(params)
        }
        LL.popViewController(animated: animated)
    }
    public static func present(urlString: String, animated: Bool, completion: (() -> Void)? = nil) {
        guard let dict = configDict else {
            log("请按照说明添加对应的plist文件")
            return
        }
        LL.presentViewController(LL.initVC(urlString: urlString, query: nil, dict: dict), animated: animated, completion: completion)
    }
}
