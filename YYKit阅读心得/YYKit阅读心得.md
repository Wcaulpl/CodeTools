###YYDispatchQueuePool阅读笔记

调度队列池，用于控制队列的线程数。大量的任务提交到后台队列时，会存在被锁住的现象导致线程休眠，或者被阻塞。 YYDispatchQueuePool，为不同优先级创建和 CPU 数量相同的 serial queue，每次从 pool 中获取 queue 时，会轮询返回其中一个 queue。App 内所有异步操作，包括图像解码、对象释放、异步绘制等，都按优先级不同放入了全局的 serial queue 中执行，这样尽量避免了过多线程导致的性能问题。

### 个人阅读理解###

YYDispatchQueuePool 是通过 YYDispatchContext 的结构体实现队列分配与控制的。name是一个标签，标识类型的、  queues 是一个队列数组 、 queueCount是CPU总数或者队列数(本身就是根据CPU总数创建的队列数) 、 counter 暂时理解为 计数器

#####YYDispatchQueuePool 根据系统优先级分五个不同类型的线程```

* <u>NSQualityOfServiceUserInteractive</u> // 与用户交互的任务，这些任务通常跟UI级别的刷新相关，比如动画，这些任务需要在一瞬间完成


* NSQualityOfServiceUserInitiated // // 由用户发起的并且需要立即得到结果的任务，比如滑动scroll view时去加载数据用于后续cell的显示，这些任务通常跟后续的用户交互相关，在几秒或者更短的时间内完成
* NSQualityOfServiceUtility  // 一些可能需要花点时间的任务，这些任务不需要马上返回结果，比如下载的任务，这些任务可能花费几秒或者几分钟的时间
* NSQualityOfServiceBackground // 这些任务对用户不可见，比如后台进行备份的操作，这些任务可能需要较长的时间，几分钟甚至几个小时
* _~~NSQualityOfServiceDefault // 优先级介于user-initiated 和 utility，当没有 QoS信息时默认使用，~~开发者不应该使用这个值来设置自己的任务_

####调度队列池的实现

```
比如：现在需要刷新UI
dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceUserInteractive), ^{   });

/*
* 函数返回 dispatch_queue_t 队列
*/
dispatch_queue_t YYDispatchQueueGetForQOS(NSQualityOfService qos) {
    return YYDispatchContextGetQueue(YYDispatchContextGetForQOS(qos));
}

/*
* 根据系统优先级 创建 YYDispatchContext 结构体
*/
static YYDispatchContext *YYDispatchContextGetForQOS(NSQualityOfService qos) {
    static YYDispatchContext *context[5] = {0};
    switch (qos) {
        case NSQualityOfServiceUserInteractive: {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount; // cup 总数
                count = count < 1 ? 1 : count > MAX_QUEUE_COUNT ? MAX_QUEUE_COUNT : count;
                context[0] = YYDispatchContextCreate("com.ibireme.yykit.user-interactive", count, qos);
            });
            return context[0];
        } break;
        case NSQualityOfServiceUserInitiated: {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
                count = count < 1 ? 1 : count > MAX_QUEUE_COUNT ? MAX_QUEUE_COUNT : count;
                context[1] = YYDispatchContextCreate("com.ibireme.yykit.user-initiated", count, qos);
            });
            return context[1];
        } break;
        case NSQualityOfServiceUtility: {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
                count = count < 1 ? 1 : count > MAX_QUEUE_COUNT ? MAX_QUEUE_COUNT : count;
                context[2] = YYDispatchContextCreate("com.ibireme.yykit.utility", count, qos);
            });
            return context[2];
        } break;
        case NSQualityOfServiceBackground: {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
                count = count < 1 ? 1 : count > MAX_QUEUE_COUNT ? MAX_QUEUE_COUNT : count;
                context[3] = YYDispatchContextCreate("com.ibireme.yykit.background", count, qos);
            });
            return context[3];
        } break;
        case NSQualityOfServiceDefault:
        default: {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
                count = count < 1 ? 1 : count > MAX_QUEUE_COUNT ? MAX_QUEUE_COUNT : count;
                context[4] = YYDispatchContextCreate("com.ibireme.yykit.default", count, qos);
            });
            return context[4];
        } break;
    }
}

/*
* 根据系统优先级 获取 YYDispatchContext 包含的queues中的 dispatch_queue_t
*/
static dispatch_queue_t YYDispatchContextGetQueue(YYDispatchContext *context) {
    uint32_t counter = (uint32_t)OSAtomicIncrement32(&context->counter);//将指定的整数值增加1。
    void *queue = context->queues[counter % context->queueCount];
    return (__bridge dispatch_queue_t)(queue);
}


```

​    

```
typedef struct {
    const char *name; // queue的标签
    void **queues; // queue数组
    uint32_t queueCount; // 可用数
    int32_t counter; // 所创建的任务的总数，共享属性，需要写锁。
} YYDispatchContext;

/**
 创建一个线程上下文

 @param name 名字
 @param queueCount 线程数量
 @param qos 系统优先级
 @return 上下文
 */
static YYDispatchContext *YYDispatchContextCreate(const char *name,
                                                 uint32_t queueCount,
                                                 NSQualityOfService qos) {
    // 创建一个上下文,分配空间
    YYDispatchContext *context = calloc(1, sizeof(YYDispatchContext));
    if (!context) return NULL;
    context->queues =  calloc(queueCount, sizeof(void *));
    if (!context->queues) {
        free(context);
        return NULL;
    }

    // dispatch_qos_class_t iOS 8.0之后才能使用
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        dispatch_qos_class_t qosClass = NSQualityOfServiceToQOSClass(qos);
        
        // 根据传入的线程数量 循环创建队列
        for (NSUInteger i = 0; i < queueCount; i++) {
            dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, qosClass, 0);
            dispatch_queue_t queue = dispatch_queue_create(name, attr);
            context->queues[i] = (__bridge_retained void *)(queue);
        }
    } else {
        // 版本低于8.0 使用 dispatch_set_target_queue方法创建线程
        long identifier = NSQualityOfServiceToDispatchPriority(qos);
        for (NSUInteger i = 0; i < queueCount; i++) {
            dispatch_queue_t queue = dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL);
            dispatch_set_target_queue(queue, dispatch_get_global_queue(identifier, 0));
            context->queues[i] = (__bridge_retained void *)(queue);
        }
    }
    
    context->queueCount = queueCount;
    if (name) {
         context->name = strdup(name);
    }
    return context;
}

```

#### YYDispatchQueuePool的使用

> ```
> // 从全局的 queue pool 中获取一个 queue
> dispatch_queue_t queue = YYDispatchQueueGetForQOS(NSQualityOfServiceUtility);
> ```

> ```
> // 创建一个新的 serial queue pool
> YYDispatchQueuePool *pool = [[YYDispatchQueuePool alloc] initWithName:@"file.read" queueCount:5 qos:NSQualityOfServiceBackground];
> dispatch_queue_t queue = [pool queue];
> ```



## YYModel阅读分析

