//
//  ViewController.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/11.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let push = UIButton(type: .custom)
        push.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        push.setTitle("go到下个页面", for: .normal)
        push.setTitleColor(UIColor.blue, for: .normal)
        push.addTarget(self, action: #selector(pushClick), for: .touchUpInside)
        if let vc:ViewController = LL.currentViewController as? ViewController {
            vc.view.addSubview(push)
        }
        let push2 = UIButton(type: .custom)
        push2.setTitle("present到下个页面", for: .normal)
        push2.setTitleColor(UIColor.blue, for: .normal)
        push2.frame = CGRect(x: 100, y: 300, width: 200, height: 100)
        push2.addTarget(self, action: #selector(presentClick), for: .touchUpInside)
        if let vc:ViewController = LL.currentViewController as? ViewController {
            vc.view.addSubview(push2)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func pushClick() {
//        Router.go(urlString: "tradeaider://qc/notarization", animated: true)
        Router.go(urlString: "tradeaider://qc/notarization?uid=1",query: ["uid": 3] , animated: true) { (params) in
            log("回到ViewController 参数=\(params ?? ["":""])")
        }
    }
    @objc func presentClick() {
        Router.present(urlString: "tradeaider://qc/notarization?uid=1", animated: true) {
            log("ViewController开始present")
        }
    }
}

