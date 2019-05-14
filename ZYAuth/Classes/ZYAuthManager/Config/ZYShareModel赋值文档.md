# 各个平台, 不同类型model 赋值文档


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
