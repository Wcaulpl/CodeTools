# CodeTools

### 无数据 底图 LYEmptyView

### 滚动label  XYAutoScrollLabel

### 日历数据模型 HYCGetDateAttribute

### 字符串时间转换  NSString+Date

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



### 单例宏定义

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

