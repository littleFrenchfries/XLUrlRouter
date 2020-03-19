//
//  URLNavigation.swift
//  SHUrlRouter
//
//  Created by wangxu on 2020/3/11.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit

public extension LL where Base: UIViewController {
    // Mark: -取出当前手机屏幕显示的界面
    static var currentViewController: UIViewController? {
        var resultVC: UIViewController?
        if #available(iOS 13.0, *) {
            let window = (UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate)?.window
             resultVC = _topVC(window??.rootViewController)
        } else {
            let window = UIApplication.shared.windows.first
            resultVC = _topVC(window?.rootViewController)
            // Fallback on earlier versions
        }
        while resultVC?.presentedViewController != nil {
            resultVC = _topVC(resultVC?.presentedViewController)
        }
        return resultVC
    }
    static private func _topVC(_ vc: UIViewController?) -> UIViewController? {
        if vc is UINavigationController {
            return _topVC((vc as? UINavigationController)?.topViewController)
        } else if vc is UITabBarController {
            return _topVC((vc as? UITabBarController)?.selectedViewController)
        } else {
            return vc
        }
    }
    // Mark: - 取出当前手机屏幕显示的界面的导航控制器
    static var currentNavigationViewController: UINavigationController? {
        currentViewController?.navigationController
    }
    
    
    // Mark: - 返回当前控制器的前一个控制器
    static var lastViewController: UIViewController? {
        guard let count: Int = currentNavigationViewController?.children.count else { return nil }
        if count<2 {
            return nil
        } else {
            return currentNavigationViewController?.children[count - 2]
        }
    }
    
    /// 设置为根控制器【概述】
    ///
    /// - Parameter viewController: 跟控制器
    ///
    static func setRootViewController(_ viewController: UIViewController) {
        UIApplication.shared.windows.first?.rootViewController = viewController
    }
    
    /// 跳转到新页面【概述】
    ///
    /// - Parameter viewController: 要跳转的控制器
    /// - Parameter animated: 是否需要跳转动画
    /// - Parameter replace:如果当前控制器和要push的控制器是同一个,可以将replace设置为Yes,进行替换.
    ///
    static func pushViewController(_ viewController: UIViewController?, animated: Bool, _ replace: Bool) {
        guard let vc = viewController else {
            log("请添加与url相匹配的控制器到plist文件中,或者协议头可能写错了!")
            return
        }
        if vc.isKind(of: UINavigationController.self) {
            setRootViewController(vc)
        } else {
            guard let navigationController = currentNavigationViewController else {
                setRootViewController(UINavigationController(rootViewController: vc))
                return
            }
            if replace {
                var viewControllers = navigationController.viewControllers
                viewControllers.removeLast()
                viewControllers.append(vc)
                navigationController.setViewControllers(viewControllers, animated: animated)
            } else {
                navigationController.pushViewController(vc, animated: animated)
            }
        }
    }
    
    /// 跳转到新页面【概述】
    ///
    /// - Parameter viewController: 要跳转的控制器
    /// - Parameter animated: 是否需要跳转动画
    /// - Parameter completion:跳转完成后需要的操作
    ///
    static func presentViewController(_ viewController: UIViewController?, animated: Bool, completion: (() -> Void)? = nil) {
        guard let vc = viewController else {
            log("请添加与url相匹配的控制器到plist文件中,或者协议头可能写错了!")
            return
        }
        guard let currentVC = currentViewController else {
            setRootViewController(vc)
            return
        }
        currentVC.present(vc, animated: animated, completion: completion)
    }
    
    /// 返回前控制器n次【概述】
    ///
    /// - Parameter times: 需要返回的次数
    /// - Parameter animated: 是否需要跳转动画
    ///
    static func popViewController(times: Int = 1, animated: Bool) {
        guard let count:Int = currentNavigationViewController?.viewControllers.count else { return }
        guard let navigationC = currentNavigationViewController else { return }
        if count > times {
            navigationC.popToViewController(navigationC.viewControllers[count - 1 - times], animated: animated)
        }else {
            log("确定可以pop掉那么多控制器?")
        }
    }
    
    /// 返回前控制器2次【概述】
    ///
    /// - Parameter animated: 是否需要跳转动画
    ///
    static func popTwiceViewController(animated: Bool) {
        popViewController(times: 2, animated: animated)
    }
    
    /// 返回到根控制器【概述】
    ///
    /// - Parameter animated: 是否需要跳转动画
    ///
    static func popToRootViewController(animated: Bool) {
        guard let count:Int = currentNavigationViewController?.viewControllers.count else { return }
        popViewController(times: count - 1, animated: animated)
    }
    
    /// 返回前控制器n次【概述】
    ///
    /// - Parameter times: 需要返回的次数
    /// - Parameter animated: 是否需要跳转动画
    /// - Parameter completion:跳转完成后需要的操作
    ///
    static func dismissViewController(times: Int = 1, animated: Bool, completion: (() -> Void)? = nil) {
        guard var currentVC = currentViewController else { return }
        if times == 0 { return }
        for _ in 1...times {
            guard let currentVC_1 = currentVC.presentingViewController else {
                log("确定能dismiss掉这么多控制器?")
                return
            }
            currentVC = currentVC_1
        }
        currentVC.dismiss(animated: animated, completion: completion)
    }
    
    /// 返回前控制器2次【概述】
    ///
    /// - Parameter animated: 是否需要跳转动画
    /// - Parameter completion:跳转完成后需要的操作
    ///
    static func dismissTwiceViewController(animated: Bool, completion: (() -> Void)? = nil) {
        dismissViewController(times: 2, animated: animated, completion: completion)
    }
    
    /// 返回根控制器【概述】
    ///
    /// - Parameter animated: 是否需要跳转动画
    /// - Parameter completion:跳转完成后需要的操作
    ///
    static func dismissToRootViewController(animated: Bool, completion: (() -> Void)? = nil) {
        guard var currentVC = currentViewController else { return }
        while let currentVC_1 = currentVC.presentingViewController {
            currentVC = currentVC_1
        }
        currentVC.dismiss(animated: animated, completion: completion)
    }
}

