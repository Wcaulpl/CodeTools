# CodeTools    
```
下一步整理正则表达式 自动生成 正则字符
```

### 无数据 底图 LYEmptyView

### 二维码生成扫描 LBXScan

### 权限请求判断 LBXPermission

### 滚动label  XYAutoScrollLabel

### 日历数据模型 XYDateAttribute 或 NSDate+XYAttribute

### 字符串时间转换  NSString+Date

### 字符串正则表达式  NSString+Regular

### 字符串加密解密  NSString+Encrypt

### 设备类型判断 

```
typedef NS_ENUM(NSInteger,DeviceType) {
    
    Unknown = 0,
    Simulator,
    IPhone_1G,          //基本不用
    IPhone_3G,          //基本不用
    IPhone_3GS,         //基本不用
    IPhone_4,           //基本不用
    IPhone_4s,          //基本不用
    IPhone_5,
    IPhone_5C,
    IPhone_5S,
    IPhone_SE,
    IPhone_6,
    IPhone_6P,
    IPhone_6s,
    IPhone_6s_P,
    IPhone_7,
    IPhone_7P,
    IPhone_8,
    IPhone_8P,
    IPhone_X,
};

+ (DeviceType)deviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
    //simulator
    if ([platform isEqualToString:@"i386"])          return Simulator;
    if ([platform isEqualToString:@"x86_64"])        return Simulator;
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])     return IPhone_1G;
    if ([platform isEqualToString:@"iPhone1,2"])     return IPhone_3G;
    if ([platform isEqualToString:@"iPhone2,1"])     return IPhone_3GS;
    if ([platform isEqualToString:@"iPhone3,1"])     return IPhone_4;
    if ([platform isEqualToString:@"iPhone3,2"])     return IPhone_4;
    if ([platform isEqualToString:@"iPhone4,1"])     return IPhone_4s;
    if ([platform isEqualToString:@"iPhone5,1"])     return IPhone_5;
    if ([platform isEqualToString:@"iPhone5,2"])     return IPhone_5;
    if ([platform isEqualToString:@"iPhone5,3"])     return IPhone_5C;
    if ([platform isEqualToString:@"iPhone5,4"])     return IPhone_5C;
    if ([platform isEqualToString:@"iPhone6,1"])     return IPhone_5S;
    if ([platform isEqualToString:@"iPhone6,2"])     return IPhone_5S;
    if ([platform isEqualToString:@"iPhone7,1"])     return IPhone_6P;
    if ([platform isEqualToString:@"iPhone7,2"])     return IPhone_6;
    if ([platform isEqualToString:@"iPhone8,1"])     return IPhone_6s;
    if ([platform isEqualToString:@"iPhone8,2"])     return IPhone_6s_P;
    if ([platform isEqualToString:@"iPhone8,4"])     return IPhone_SE;
    if ([platform isEqualToString:@"iPhone9,1"])     return IPhone_7;
    if ([platform isEqualToString:@"iPhone9,3"])     return IPhone_7;
    if ([platform isEqualToString:@"iPhone9,2"])     return IPhone_7P;
    if ([platform isEqualToString:@"iPhone9,4"])     return IPhone_7P;
    if ([platform isEqualToString:@"iPhone10,1"])    return IPhone_8;
    if ([platform isEqualToString:@"iPhone10,4"])    return IPhone_8;
    if ([platform isEqualToString:@"iPhone10,2"])    return IPhone_8P;
    if ([platform isEqualToString:@"iPhone10,5"])    return IPhone_8P;
    if ([platform isEqualToString:@"iPhone10,3"])    return IPhone_X;
    if ([platform isEqualToString:@"iPhone10,6"])    return IPhone_X;
    return Unknown;
}
```

### 数组更新

```
- (void)conditionsByGenerating:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))generate {
    if (generate) {
        NSMutableArray *array = [NSMutableArray array];
        BOOL isStop = false;
        for (int i = 0; i < self.count; i++) {
            if (i == self.count-1) {
                isStop = true;
            }
            id obj = generate(self[i], i, &isStop);
            if (obj) {
                [self replaceObjectAtIndex:i withObject:obj];
            } else {
                [array addObject:self[i]];
            }
        }
        [self removeObjectsInArray:array];
    }
}
```


### 常用宏定义
#### 1.单例宏

```
#define XY_SINGLETON_DEF(_type_) + (_type_ *)sharedInstance;\
+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));

#define XY_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance{\
static _type_ *theSharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theSharedInstance = [[super alloc] init];\
});\
return theSharedInstance;\
}
```

#### 2.屏幕宽高

```
支持横屏可以用下面的宏:
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif
```

#### 3.颜色宏

```
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0)
#define HEX(hex, a) RGBA(((float)((hex & 0xFF0000) >> 16)), ((float)((hex & 0xFF00) >> 8)), ((float)(hex & 0xFF)), a)
```

#### 4.自定义Log

```
#ifdef DEBUG
#define XYLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define XYLog(...)
#endif
```

#### 5.获取当前语言

```
#define XYCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
```

#### 6.沙盒目录文件

```
//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
```

#### 7.强弱引用宏

```
#define weakify(obj) __typeof__(obj) __weak obj##__weak_ = obj

#define strongify(obj) __typeof__(obj##__weak_) __strong obj = obj##__weak_
```

#### 8.手机系统版本

```
#define XYSystemVersion [[UIDevice currentDevice] systemVersion]
```

#### 9.是否空类

```
#define IS_NULL(obj) [obj isEqual:[NSNull null]]
```

#### 10.角度弧度转换

```
#define XYDegreesToRadian(degrees) (M_PI * (degrees) / 180.0)

#define XYRadianToDegrees(radian) (radian*180.0)/(M_PI)
```

#### 11.设置圆角

```
// 全部圆角设置
#define XYViewBorderRadius(view, radius) view.layer.masksToBounds=YES;\
view.layer.cornerRadius=radius;

// 各个圆角设置
#define XYViewCornerRadius(view, radius, rectCorner) CAShapeLayer *shapeLayer = [CAShapeLayer layer];\
shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)].CGPath;\
view.layer.mask = shapeLayer
```

#### 12.屏幕截图

```
#define XYscreenShot(view) \
({\
UIGraphicsBeginImageContext(view.frame.size);\
[view.layer renderInContext:UIGraphicsGetCurrentContext()];\
UIImage *img = UIGraphicsGetImageFromCurrentImageContext();\
UIGraphicsEndImageContext();\
(img);\
})\
```

#### 13.属性快速声明

```
//property属性快速声明
#define XYPropStatement(propertyModifier, propertyPointerType, propertyName)                  \
@property(nonatomic, propertyModifier)propertyPointerType propertyName
 
//属性方法快速声明
#define XYPropStatementAndFuncStatement(propertyModifier,className, propertyPointerType, propertyName)                  \
@property(nonatomic, propertyModifier)propertyPointerType propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define XYPropSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
self.propertyName = propertyName;                                                                                       \
return self;                                                                                                            \
};                                                                                                                      \
}
```

#### 14.GCD宏定义

```
//GCD - 一次性执行

#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock)

//GCD - 在Main线程上运行

#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock)

//GCD - 开启异步线程

#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), globalQueueBlock)

//GCD - 安全访问

#ifndef dispatch_main_async_safe

#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) ==0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif
```



### 判断控制器 是否存在 并显示

```
+ (instancetype)getViewVcWithRootVc:(UIViewController *)rootVc {
    id vc;
    if (!rootVc) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        rootVc = window.rootViewController;
    }
    
    if ([rootVc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVc = (UITabBarController *)rootVc;
        for (UIViewController *viewVc in tabBarVc.childViewControllers) {
            vc = [self getViewVcWithRootVc:viewVc];
            if (vc) {
                tabBarVc.selectedViewController = viewVc;
                return vc;
            }
        }
    } else if ([rootVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *naviVc = (UINavigationController *)rootVc;
        for (UIViewController *viewVc in naviVc.childViewControllers) {
            vc = [self getViewVcWithRootVc:viewVc];
            if (vc) {
                if (![vc isEqual:naviVc.childViewControllers.lastObject]) {
                    [naviVc popToViewController:vc animated:NO];
                }
                return vc;
            }
        }
    } else if ([rootVc isKindOfClass:[self class]]) {
        vc = rootVc;
        return vc;
    }
    return vc;
}
```

### 获取当前控制器

```
+ (UIViewController *)getCurrentVC {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }

    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }

    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}
```

### button 图片文本相对位置

```
typedef enum : NSUInteger {
    buttonModeTop,
    buttonModeBottom,
    buttonModeLeft,
    buttonModeRight,
} XYButtonMode;

- (void)xy_locationAdjustWithMode:(XYButtonMode)buttonMode spacing:(CGFloat)spacing {
    CGSize imageSize = [self imageRectForContentRect:self.frame].size;
    UIFont *titleFont = self.titleLabel.font;
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    UIEdgeInsets titleInsets;
    UIEdgeInsets imageInsets;
    switch (buttonMode) {
        case buttonModeTop:
            titleInsets = UIEdgeInsetsMake((imageSize.height + titleSize.height + spacing)/2, -(imageSize.width), 0, 0);
            imageInsets = UIEdgeInsetsMake(-(imageSize.height + titleSize.height + spacing)/2, 0, 0, -titleSize.width);
            break;
        case buttonModeBottom:
            titleInsets = UIEdgeInsetsMake(-(imageSize.height + titleSize.height + spacing)/2,
                                           -(imageSize.width), 0, 0);
            imageInsets = UIEdgeInsetsMake((imageSize.height + titleSize.height + spacing)/2, 0, 0, -titleSize.width);
            break;
        case buttonModeLeft:
            titleInsets = UIEdgeInsetsMake(0, 0, 0, -spacing);
            imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            break;
        case buttonModeRight:
            titleInsets = UIEdgeInsetsMake(0, -(imageSize.width * 2), 0, 0);
            imageInsets = UIEdgeInsetsMake(0, 0, 0, -(titleSize.width * 2 + spacing));
            break;
        default:
            break;
    }
    self.titleEdgeInsets = titleInsets;
    self.imageEdgeInsets = imageInsets;
}
```

### 打包动态库和静态库

> #### [打包动态库和静态库](https://www.jianshu.com/p/cebe06c9f275)
>
> 打包注意，真机下打包的静态库只能在真机下运行，模拟器下打包的静态库只能在模拟器下运行
>
> 1. 打包.a静态库
>
>    ![图片](https://github.com/Wcaulpl/CodeTools/blob/master/静态库/10760632-19198ca83dd37d16.png)
>
>    在.h和.m中写入方法 ，按command+b编译成功
>
>    ![10760632-18596cc2c3c6c1b8](https://github.com/Wcaulpl/CodeTools/blob/master/静态库/10760632-18596cc2c3c6c1b8.png)
>
>    鼠标右键点击，点击Show in Finder 查看静态库 
>
>    ![10760632-22453f8f4f3124a4](https://github.com/Wcaulpl/CodeTools/blob/master/静态库/10760632-22453f8f4f3124a4.png)
>
>    .a文件拖进项目使用
>
> 2. 打包.framework静态库
>
>    ![10760632-4f85bcb2fc6462a0](https://github.com/Wcaulpl/CodeTools/blob/master/静态库/10760632-4f85bcb2fc6462a0.png)
>
>    添加类方法，并把类方法的头文件导入到静态库.h里面
>
>    .framework默认是动态库
>
>    ![10760632-3e1c83a458e82ddc](https://github.com/Wcaulpl/CodeTools/blob/master/静态库/10760632-3e1c83a458e82ddc.png)
>
>    把mach-o 选到 static library就是静态
>
>    ![10760632-90d52e733ae06c85](https://github.com/Wcaulpl/CodeTools/blob/master/静态库/10760632-90d52e733ae06c85.png)
>
>    把类的.h拖到这里公开 然后command+b编译成功
>
>    ![10760632-2b80fc3503e90583](https://github.com/Wcaulpl/CodeTools/blob/master/静态库/10760632-2b80fc3503e90583.png)
>
> 3. framework动态库 把mach-o 默认是动态库 使用方法跟.framework一样，区别
>
>    ![10760632-c702cc61704f57f2](https://github.com/Wcaulpl/CodeTools/blob/master/静态库/10760632-c702cc61704f57f2.png)
>
>    使用时需要在这里添加静态库
>
> 4. 真机模拟器两用包
>
>     将真机包和模拟器包使用命令行合到一起，命令格式为lipo -create dic/xxx.framework/xxx dic2/xxx.framework/xxx -output xxx,其中dic和dic2代表生成framework的两个目录，一个是iphones一个是iphonesimulator，而xxx.framework其实就是我们在build过后生成的framework包了，最后output后边的xxx 其实就是最后合成生成的文件，最后将文件覆盖到iphones里边，就会替换原有的xxx文件，具体目录结构如图   ![未命名图片-1024x218](https://github.com/Wcaulpl/CodeTools/blob/master/静态库/未命名图片-1024x218.png)上图红色箭头所指部分为生成合成文件将要覆盖的文件，覆盖完成后可以直接将Release-iphones里边将framework文件拿来直接用了，可以用于真机和模拟器的framework动态包就出世了。
>
>
>
>     用法和其他framework用法完全一致，注意事项就是在引用生成的framework的同时需要在工程中引入生成的framework的相关其他引用即系统以及第三方的framework的引入以及静态库的引入，还有一个设置是在other linker flags下设置-ObjC，整个过程就是这样。
>



### CocoaPods创建自己的公开库、私有库

> #### CocoaPods创建自己的公开库
>
> >1. **注册Trunk** 
> >
> >   - runk需要CocoaPods 0.33版本以上  用`pod --version` 命令查看版本
> >
> >   如果版本低，需要升级：
> >
> >   ```
> >   sudo gen install cocoapods
> >   pod setup
> >   ```
> >
> >   - 查看自己是否注册过Trunk
> >
> >     ```
> >     pod trunk me
> >     ```
> >
> >     - 如果没有注册过![1545100579803](https://github.com/Wcaulpl/CodeTools/blob/master/CocoaPods创建自己的公开库、私有库/1545100579803.jpg)
> >
> >     - 注册
> >
> >       ```
> >       pod trunk register slzxy14@163.com "Wcaulpl" --verbose
> >       
> >       "Wcaulpl" 里面代表你的用户名，最好起一个好的名字
> >       slzxy14@163.com 代表你的邮箱
> >       ```
> >
> >     - 注册成功后可以再查看一下个人信息pod trunk me
> >
> >       ![1545100993485](https://github.com/Wcaulpl/CodeTools/blob/master/CocoaPods创建自己的公开库、私有库/1545100993485.jpg)
> >
> >2. **创建一个项目**
> >
> >   * GitHub 上创建一个项目![1545112933774](https://github.com/Wcaulpl/CodeTools/blob/master/CocoaPods创建自己的公开库、私有库/1545112933774.jpg)
> >   * 将项目clone 下来，并添加 代码文件![1545114894849](https://github.com/Wcaulpl/CodeTools/blob/master/CocoaPods创建自己的公开库、私有库/1545114894849.jpg)
> >
> >3. **创建编辑.podspec**
> >
> >   1. cd 到你的项目下
> >
> >      ```
> >      //  XYAutoScrollLabel 这个是你框架的名称
> >      2、pod spec create XYAutoScrollLabel
> >      ```
> >
> >   2. 编辑.podspec
> >
> >      ```
> >      Pod::Spec.new do |s|
> >        s.name         = "XYAutoScrollLabel"  #名称，pod search 搜索的关键词,注意这里一定要和.podspec的名称一样,否则报错
> >        s.version      = "0.0.1" #版本号
> >        s.summary      = "一个文本超出文本框时自动滚动显示 的开源控件" #简介
> >        s.description  = <<-DESC
> >                         DESC
> >        s.homepage     = "https://github.com/Wcaulpl/XYAutoScrollLabel" #项目主页地址
> >        s.license      = { :type => "MIT", :file => "FILE_LICENSE" } #许可证
> >        s.author             = { "Wcaulpl" => "slzxy14@163.com" } #作者
> >        s.source       = { :git => "https://github.com/Wcaulpl/XYAutoScrollLabel.git", :tag => "#{s.version}" } #项目的地址
> >        s.source_files  = "XYAutoScrollLabel", "XYAutoScrollLabel/*.{h,m}" #需要包含的源文件
> >        s.public_header_files = "XYAutoScrollLabel/XYAutoScrollLabel.h" #公开的头文件
> >        s.resources: 资源文件
> >        s.dependency：依赖库，不能依赖未发布的库，可以写多个依赖库
> >      
> >      ```
> >
> >   3. 上传git 并 打tag
> >
> >      将包含配置好的 .podspec, LICENSE 的项目提交 Git
> >
> >      ```
> >      //为git打tag
> >      git tag "0.0.1" 
> >      //将tag推送到远程仓库
> >      git push --tags
> >      ```
> >
> >4. **验证.podspec文件**
> >
> >   ```
> >   pod spec lint XYAutoScrollLabel.podspec --verbose
> >   pod lib lint --allow-warnings // 出现警告
> >   ```
> >
> >5. **发布**
> >
> >   ```
> >   发布时会验证 Pod 的有效性，如果你在手动验证 Pod 时使用了 --use-libraries 或 --allow-warnings 等修饰符，那么发布的时候也应该使用相同的字段修饰，否则出现相同的报错。
> >   // --use-libraries --allow-warnings
> >   pod trunk push XYAutoScrollLabel.podspec
> >   ```
> >
> >   **出现这种情况就说明你发布成功了，等待人家审核就行了**![1545119099543](https://github.com/Wcaulpl/CodeTools/blob/master/CocoaPods创建自己的公开库、私有库/1545119099543.jpg)
> >
> >   **验证仓库` pod search XYAutoScrollLabel ` 或 ` pod trunk me` ** 
>
> #### CocoaPods创建自己的私有库
>
>



### 自动化测试工具 FastMonkey


