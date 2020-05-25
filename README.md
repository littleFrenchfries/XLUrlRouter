# XLUrlRouter
A swift navigation control router
## swift 路由器跳转库XLUrlRouter功能介绍
### XLUrlRouter主要针对控制器跳转，使用简洁明了
本路由器借鉴[DCURLRouter](https://github.com/DarielChen/DCURLRouter) ,[DCURLRouter](https://github.com/DarielChen/DCURLRouter)是OC的路由器框架，由于项目用swift重构，swift当前路由框架没有特别适合我的，所以我自己搭建了这么一个[XLUrlRouter](https://www.jianshu.com/p/d1ed55e7e763)框架，纯swift封装，喜欢给个star。

### 具体使用说明如下：
1. 创建一个.plist文件，内容大致如下：
![图片名称](https://upload-images.jianshu.io/upload_images/6573541-bf96ec1425ee9886.png?imageMogr2/auto-orient/strip|imageView2/2)  
可以创建类似的plist文件，内容不用完全相同，但是层次要相同
2. 在项目的AppDelegate里面注册控制器，如图
#```
Router.loadConfigDict(pistName: "DCURLRouter.plist")
Router.loadConfigDict(pistName: "DCURLRouter")
#```
![图片名称](https://upload-images.jianshu.io/upload_images/6573541-abff06c7caa7333b.png?imageMogr2/auto-orient/strip|imageView2/2/w/1132)  
红线框内的两种注册方式都可以，代码中做了兼容处理，为了使框架更为友好
3. 框架中有两个主文件Router和LL
Router主要负责根据URL路径进行跳转的功能：
* 1. 控制器的pushViewController功能：
#```
Router.go(urlString:"url路径",query: ["参数":参数] , animated:true) { (params)in
           log("回到ViewController 参数=\(params ?? ["":""])")
}
#```
* 2. 控制器的presentViewController功能：
#```
Router.present(urlString: "url路径", animated: true) {
            log("ViewController开始present")
}
#```
* 3. 控制器的popViewController功能：
#```
Router.goBack(params: ["uid":2], animated:true)
#```
LL主要负责系统控制器跳转的功能，可以在任何地方进行跳转，不受限制
* 1. 控制器的pushViewController功能：
#```
LL.pushViewController(vc, animated: animated,false)
#```
* 2. 控制器的presentViewController功能：
#```
LL.presentViewController(vc, animated: animated, completion: completion)
#```
* 3. 控制器的popViewController功能：
#```
LL.popViewController(animated: animated)
#```
可以pop两次：
#```
LL.popTwiceViewController(animated: true)
#```
也可以pop到跟控制器：
#```
LL.popToRootViewController(animated: true)
#```
还可以pop多次：
#```
LL.popViewController(times: n, animated:true)
#```
* 4. 控制器的dismissViewController功能：
#```
LL.dismissViewController(animated: true)
#```
可以dismiss两次：
#```
LL.dismissTwiceViewController(animated: true)
#```
也可以dismiss到跟控制器：
#```
 LL.dismissToRootViewController(animated: true)
 #```
还可以dismiss多次：
#```
LL.dismissViewController(times: n, animated:true)
#```
# 功能就大概如上所示了，还有获取当前控制器等功能，大家基本也都会的就不介绍了。欢迎大家使用本框架，喜欢的可以给个star

