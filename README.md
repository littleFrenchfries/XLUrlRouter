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
