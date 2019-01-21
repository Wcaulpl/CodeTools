YYAsyncLayer为了异步绘制而继承CALayer的子类。在子线程中绘制内容Context，绘制完成后，回到主线程对layer.contents进行直接显示。控制了渲染线程的数量以及通过原子计数YYSentinel控制了取消异步渲染的内容。通过delegate回调，可以使得不同的delegate对象在block中绘制需要的内容。 

#### 方法说明

```
//是否异步渲染
@property BOOL displaysAsynchronously;

/**
 YYAsyncLayer's的delegate协议，一般是uiview。必须实现这个方法
 */
@protocol YYAsyncLayerDelegate <NSObject>
@required
//当layer的contents需要更新的时候，返回一个新的展示任务
- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask;
@end

/**
 YYAsyncLayer在后台渲染contents的显示任务类
 */
@interface YYAsyncLayerDisplayTask : NSObject

/**
 这个block会在异步渲染开始的前调用，只在主线程调用。
 */
@property (nullable, nonatomic, copy) void (^willDisplay)(CALayer *layer);

/**
 这个block会调用去显示layer的内容
 */
@property (nullable, nonatomic, copy) void (^display)(CGContextRef context, CGSize size, BOOL(^isCancelled)(void));

/**
 这个block会在异步渲染结束后调用，只在主线程调用。
 */
@property (nullable, nonatomic, copy) void (^didDisplay)(CALayer *layer, BOOL finished);

```

