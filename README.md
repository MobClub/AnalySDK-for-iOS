# AnalySDK For iOS
### [AnalySDK](http://analysdk.mob.com/),又称MOB统计分析,为您的App提供精准化行为分析、多维数据模型、匹配全网标签、垂直行业分析。

**当前支持的 AnalySDK 版本**

- iOS v1.1.1

**集成文档**

- [iOS](http://wiki.mob.com/%E3%80%90%E4%BA%91%E7%AB%AF%E7%89%88%E3%80%91%E3%80%90ios%E3%80%91%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%96%87%E6%A1%A3%EF%BC%88mob%E7%BB%9F%E8%AE%A1%E5%88%86%E6%9E%90%EF%BC%89/)

- - - - - - - - - - - -

### 一、获取AppKey,AppSecret

##### 1.打开Mob官网，在官网选择登录或注册，新用户先注册，老用户直接登录。

![](http://wiki.mob.com/wp-content/uploads/2017/10/51.png)

注册页面如下图:
![](http://wiki.mob.com/wp-content/uploads/2017/10/52.png)

##### 2.注册或登录完成后，会返回首页，点击右上⻆的“进⼊后台”，会跳转⾄管理后台，点击左侧，选择“添加应⽤”。如下图：
填入应用名称:
![](http://wiki.mob.com/wp-content/uploads/2017/10/53.png)

完成创建即可得到appkey和appsecret
![](http://wiki.mob.com/wp-content/uploads/2017/10/54.png)

选择’添加产品’,找到移动AnalySDK，点击马上开始，至此你的appkey将开始对AnalySDK生效
![](http://wiki.mob.com/wp-content/uploads/2017/10/160.png)

##### 3.从上述步骤申请并获取所得的AppKey, AppSecret,请在项目的Info.plist中分别添加’MOBAppKey’, ‘MOBAppSecret’此两字段并分别对应填入,如图
![](http://wiki.mob.com/wp-content/uploads/2017/10/56.png)

### 二、下载SDK并添加到项目

##### （1）手动导入SDK
解压后名为SDK的文件夹内会包含以下内容

```
AnalySDK
AnalySDK.framework – 统计SDK核心库
Required
MOBFoundation.framework – 基础工具库
```

![](http://wiki.mob.com/wp-content/uploads/2017/10/57.png)
选择Copy以复制SDK到项目
![](http://wiki.mob.com/wp-content/uploads/2017/10/58.png)

添加系统依赖库:

```
-libstdc++
 
-libz1.2.5
```
![](http://wiki.mob.com/wp-content/uploads/2017/10/59.png)

##### （2）pod导入

1. 首先 cd 至项目的根目录，执行 pod setup；

2. 按需在 Podfile 文件中添加命令：

```
pod 'mob_analysdk'
```

3. 如果之前没有安装过，第一次使用请先执行

安装库：```pod install```

如果之前一次没有已经安装过，那只需要在执行

更新库：```pod update```


### 三、添加代码

##### 1、事件埋点

```
[AnalySDK trackEvent:@"YourEventName" eventParams:@{@"key":@"value"}];
```
每个事件应有独立的事件名称,并且传入自定义的字典参数用于统计你需要统计的数据,（事件名称创建成功后不可修改，建议使用26个字母与数字的组合，事件上传成功会在Mob统计后台项目里查看并添加描述，方便管理）

![](http://wiki.mob.com/wp-content/uploads/2017/10/144.png)

建议埋点的代码,应该部署于例如点击、回调、购买充值等一些业务场景发生的地方。

例如:

```
- (void)doSomeThing
{
[AnalySDK trackEvent:@"doSomeThing" eventParams:@{@"key":@"value"}];
}
```

添加地理位置信息(可选)

```
CLLocation *location;
[AnalySDK setLocation:location];
```
一旦添加了地理位置信息,所有的统计事件均会自动带上此位置信息

##### 2、用户事件
**支持三种用户事件:用户注册,用户登录,用户修改信息**

* 用户注册

```
//构建用户
ALSDKUser *user = [ALSDKUser userWithId:@"你的用户ID(必须)" regType:@"你的注册类型(可选)" regChannel:@"你的注册渠道(可选)"];
user.nickName = @"Jason";
user.age = @(18);
...
 
//调用注册方法
[AnalySDK userRegist:user];
```

* 用户登录

```
//构建用户
ALSDKUser *user = [ALSDKUser userWithId:@"你的用户ID(必须)" loginType:@"你的登录类型,例如微信(可选)" loginChannel:@"你的登录渠道(可选)"];
user.nickName = @"Jason";
user.age = @(18);
...
 
//调用登录方法
[AnalySDK userLogin:user];
```

* 用户更新信息

```
ALSDKUser *user = [ALSDKUser userWithId:@"你的用户ID(必须)"];
user.nickName = @"Jason";
user.gender = @"不知道男女";
user.customProperties = @{@"customkey1":@"自定义1",@"customkey2":@"自定义2"};
…
 
//调用更新信息方法
[AnalySDK userUpdate:user];
```

##### 3、角色事件
**[更适用于游戏使用]**

* 角色创建

```
//构建角色对象
ALSDKRole *role = [ALSDKRole roleWithUserId:@"你的用户ID(必须)" roleId:@"你的角色ID(必须)"];
role.roName = @"角色名称";
…
 
//创建角色
[AnalySDK roleCreate:role];
```

* 角色登录

```
//构建角色对象
ALSDKRole *role = [ALSDKRole roleWithUserId:@"你的用户ID(必须)" roleId:@"你的角色ID(必须)"];
role.roName = @"角色名称";
…
 
//角色登录
[AnalySDK roleLogin:role];
```

* 角色更新信息

```
//构建角色对象
ALSDKRole *role = [ALSDKRole roleWithUserId:@"你的用户ID(必须)" roleId:@"你的角色ID(必须)"];
role.roName = @"角色名称";
…
 
//角色登录
[AnalySDK roleLogin:role];
```

##### 4、付费事件

```
//构建付费事件
ALSDKPayEvent *payEvent = [[ALSDKPayEvent alloc] init];
payEvent.payMoney = 9900;
payEvent.payContent = @"月卡";
…
 
//记录付费事件
[AnalySDK trackPayEvent:payEvent];
```

>注意：Mob统计游戏专版为游戏行业做了垂直化定制，提供了3类共7个事件作为特殊事件；
强烈建议您调用SDK提供的方法直接埋点，这样将为您自动生成LTV、ARPU、ARRPU等游戏版专属数据分析模型
[查看详情](http://wiki.mob.com/%E6%B8%B8%E6%88%8F%E7%89%88%E5%BB%BA%E8%AE%AE%E5%9F%8B%E7%82%B9%E4%BA%8B%E4%BB%B6/)

- - - - - - - - - - - -
集成中如遇到任何技术问题,欢迎咨询免费技术支持
QQ:4006852216
电话:400-685-2216


