# CodeTools

### 无数据 底图 LYEmptyView

### 滚动label  XYAutoScrollLabel

### 日历数据模型 HYCGetDateAttribute

### 字符串时间转换  NSString+Date

###字符串正则表达式  NSString+Regular

###字符串加密解密  NSString+Encrypt

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
#define XYViewBorderRadius(view, radius)view.layer.masksToBounds=YES;\
view.layer.cornerRadius=radius;

// 各个圆角设置
#define XYViewCornerRadius(view, radius, rectCorner) CAShapeLayer *shapeLayer = [CAShapeLayer layer];\
shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)].CGPath;\
view.layer.mask = shapeLayer
```

#### 12.属性快速声明

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

#### 13.GCD宏定义

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



