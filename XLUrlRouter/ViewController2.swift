//
//  ViewController2.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/16.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit

class ViewController2: UIViewController,SHClosure {
    var ll_getParams: RouterClosure?
    
    var ll_originUrl: URL?
    
    var ll_params: Dictionary<String, Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        let push = UIButton(type: .custom)
        push.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        push.setTitle("goback到下个页面", for: .normal)
        push.setTitleColor(UIColor.blue, for: .normal)
        push.addTarget(self, action: #selector(pushClick), for: .touchUpInside)
        view.addSubview(push)
        log(ll_params)
        let push2 = UIButton(type: .custom)
        push2.setTitle("dissmiss到下个页面", for: .normal)
        push2.setTitleColor(UIColor.blue, for: .normal)
        push2.frame = CGRect(x: 100, y: 300, width: 200, height: 100)
        push2.addTarget(self, action: #selector(presentClick), for: .touchUpInside)
        if let vc:ViewController2 = LL.currentViewController as? ViewController2 {
            vc.view.addSubview(push2)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func pushClick() {
        Router.goBack(params: ["uid": 2], animated: true)
    }
    @objc func presentClick() {
        LL.dismissViewController(animated: true)
    }
}

