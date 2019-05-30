# ZYAuth

[![CI Status](https://img.shields.io/travis/378804441@qq.com/ZYAuth.svg?style=flat)](https://travis-ci.org/378804441@qq.com/ZYAuth)
[![Version](https://img.shields.io/cocoapods/v/ZYAuth.svg?style=flat)](https://cocoapods.org/pods/ZYAuth)
[![License](https://img.shields.io/cocoapods/l/ZYAuth.svg?style=flat)](https://cocoapods.org/pods/ZYAuth)
[![Platform](https://img.shields.io/cocoapods/p/ZYAuth.svg?style=flat)](https://cocoapods.org/pods/ZYAuth)



# pod方式

#### 全部导入 (目前支持 `微信/QQ/微博 Facebook/twitter/google/WhatsApp`)
* 示例
    * pod 'XCSocial', :git => "https://git.ixiaochuan.cn/xcpod/XCSocial.git"



#### 指定模块导入 
* 各个模块名称
    *   SocialCore    - 核心模块  ==必导==
    *   WechatSocial  - 微信
    *   TencenSocial  - QQ
    *   SinaSocial    - 微博
    *   GoogleSocial   - google
    *   FacebookSocial - facebook
    *   TwitterSocial  - twitter
    *   WhatsappSocial - whatsapp
##### 示例
* 列入想导入 微信, 微博
    * pod 'XCSocial', subspecs:['SocialCore', 'WechatSocial'], :git => "https://git.ixiaochuan.cn/xcpod/XCSocial.git"



#### 使用方法
* 重写AppDelegate的handleOpenURL和openURL方法：

```javascript
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {   
    return [[ZYAuthManager shareInstance] openURLWithApplication:application handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[ZYAuthManager shareInstance] openURLWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}
```
* 使用代码：

```javascript
"Auth授权"
[[XCSocialManager shareInstance] authLoginWithType:@"平台类型" viewController:@"模态所需要依附VC" success:^(NSDictionary * _Nullable dataDic) {
        NSLog(@"授权成功  %@", dataDic);
} failure:^(NSString * _Nullable errorMsg, NSError * _Nullable error) {
        NSLog(@"授权失败  error : %@", errorMsg);
}];
    
    
"分享"
* 初始化分享model (XCSocialShareModel)  注 : XCSocialShareModel 各平台所需赋值字段请参考 XCSocialShareModel

[[XCSocialManager shareInstance] shareWithShareModel:@"分享模型(XCSocialShareModel)" viewController:@"模态所需要依附VC" success:^(NSString * _Nullable succeMsg) {
        NSLog(@"分享成功  %@", succeMsg);
} failure:^(NSString * _Nullable errorMsg, NSError * _Nullable error) {
        NSLog(@"分享失败信息  error : %@", errorMsg);
}];

    
```



# 分享model构建 (XCSocialShareModel)

## 微信 ##

--------- ZYShareTypeLink ---------
urlString           (分享目标链接)
title                  (分享内容标题)
describe          (分享内容描述)
previewImage  (分享预览图(微信中不得超过32K))
shareScene     (分享到哪,目标(会话, 朋友圈 等))


--------- ZYShareTypeImage ---------
image          (分享目标图片 类型 : UIImage)
shareScene (分享到哪,目标(会话, 朋友圈 等))


--------- ZYShareTypeVideo ---------
urlString          (分享video链接)
title                  (分享内容标题)
describe          (分享内容描述)
previewImage  (分享预览图(微信中不得超过32K))
shareScene     (分享到哪,目标(会话, 朋友圈 等))


--------- ZYShareTypeMusic ---------
urlString           (音乐网页的url地址 长度不能超过10K)
musicUrl          (音乐数据url地址 长度不能超过10K)
title                  (分享内容标题)
describe          (分享内容描述)
previewImage (分享预览图(微信中不得超过32K))
shareScene     (分享到哪,目标(会话, 朋友圈 等))


--------- ZYShareTypeMinprogram ---------
urlString                         (低版本网页链接 长度不能超过1024字节)
minProgramUserName  (微信小程序username)
miniProgramPath           (微信小程序页面的路径)
miniProgramType           (微信小程序类型)
title                                 (分享内容标题)
describe                         (分享内容描述)
previewImage                (分享预览图(微信中不得超过32K))
shareScene                   (分享到哪,目标(会话, 朋友圈 等))

############################






## QQ ##

--------- ZYShareTypeText ---------
text                                (分享文本)
shareScene                   (分享到哪,目标(会话, QQ空间))


--------- ZYShareTypeLink ---------
urlString                         (内容的目标URL)
title                                 (分享内容标题)
describe                         (分享内容描述)
previewImage                (分享预览图)
shareScene                   (分享到哪,目标(会话, QQ空间))


--------- ZYShareTypeImage ---------
image                            (分享Image)
title                                (分享内容标题)
describe                        (分享内容描述)
previewImage               (分享预览图, 不赋值将会降级 拿 image字段)
shareScene                  (分享到哪,目标(会话, QQ空间))


--------- ZYShareTypeVideo ---------
不支持

--------- ZYShareTypeMusic ---------
不支持

---------  ZYShareTypeMinprogram ---------
不支持


############################







## 微博 ##

--------- ZYShareTypeText ---------
text                                (分享文本)


--------- ZYShareTypeLink ---------
text                                (分享文本)
urlString                         (内容的目标URL)
title                                 (分享内容标题)
describe                         (分享内容描述)
previewImage                (分享预览图)


--------- ZYShareTypeImage ---------
image                            (分享Image)


--------- ZYShareTypeVideo ---------
不支持


--------- ZYShareTypeTextAndImage ---------
text                                (分享文本)
image                            (分享Image)


--------- ZYShareTypeMusic ---------
不支持


---------  ZYShareTypeMinprogram ---------
不支持


############################






## Google ##

--------- ZYShareTypeText ---------
不支持

--------- ZYShareTypeLink ---------
不支持

--------- ZYShareTypeImage ---------
不支持

--------- ZYShareTypeVideo ---------
不支持

--------- ZYShareTypeTextAndImage ---------
不支持

--------- ZYShareTypeMusic ---------
不支持

---------  ZYShareTypeMinprogram ---------
不支持

############################






## Facebook ##

--------- ZYShareTypeText ---------
不支持


--------- ZYShareTypeLink ---------
urlString                         (内容的目标URL)
title                                 (分享内容标题)
previewImage                (分享预览图)


--------- ZYShareTypeImage ---------
不支持

--------- ZYShareTypeVideo ---------
facebookVideoPath       (本地视频资源)

--------- ZYShareTypeTextAndImage ---------
facebookImages           (图片集 [ UIImage 数组 ])

--------- ZYShareTypeTextAndImage ---------
不支持

--------- ZYShareTypeMusic ---------
不支持

---------  ZYShareTypeMinprogram ---------
不支持

############################





## Twitter ##

--------- ZYShareTypeText ---------
不支持

--------- ZYShareTypeLink ---------
urlString                         (内容的目标URL)
title                                 (分享内容标题)

--------- ZYShareTypeImage ---------
不支持

--------- ZYShareTypeVideo ---------
不支持

--------- ZYShareTypeTextAndImage ---------
不支持

--------- ZYShareTypeMusic ---------
不支持

---------  ZYShareTypeMinprogram ---------
不支持

############################







## Whatsapp ##

--------- ZYShareTypeText ---------
不支持


--------- ZYShareTypeLink ---------
urlString                         (内容的目标URL)


--------- ZYShareTypeImage ---------
不支持

--------- ZYShareTypeVideo ---------
不支持

--------- ZYShareTypeTextAndImage ---------
不支持

--------- ZYShareTypeMusic ---------
不支持

---------  ZYShareTypeMinprogram ---------
不支持

############################






