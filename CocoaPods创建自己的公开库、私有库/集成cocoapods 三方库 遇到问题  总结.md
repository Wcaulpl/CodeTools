集成cocoapods 三方库 遇到问题  总结

##### 验证步骤

1. 提示   linker command failed with exit code 1  
    ```
    一般为 配置 .podspec 时 库文件路径为 配置 
    如：s.vendored_frameworks = "CETVideoKit/Frameworks/IVMSNetSDK.framework", "CETVideoKit/Frameworks/VideoPlayFrmework.framework"
    以 .podspec 所在目录为根目录 CETVideoKit文件夹 和.podspec文件 在同级目录
    
    2. 上述配置正确 还是报错 看 xcconfig 配置路径是否正确 
    s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PODS_ROOT)/CETVideoKit/Frameworks','OTHER_LDFLAGS' => '$(inherited) -undefined dynamic_lookup' }
    
    ```

2. 以上都正确 还是报错 并提示 动态库中的.h 文件找不到
   有可能是 你的动态库是只能真机运行的库 那就要改 cocoapods 系统文件
   找到 validator.rb 改成一下样子

   ![1401554-0342f382290320ae](/Users/cetzxy/Desktop/1401554-0342f382290320ae.png)



```
验证 
pod lib lint --verbose  --allow-warnings --sources="https://github.com/xxx/Specs.git,https://git.xxx.com/spec.git,https://github.com/CocoaPods/Specs.git"



```

推到仓库
pod repo push xxxxx xxxxx.podspec

```
如果 你改了 validator.rb  pod truck 是不能成功的 所以 是不能发布到 官方仓库里的 (如果 你把 validator.rb 改回来 也不行 你发布的时候 还是会验证一次 so 又错)

so 只能发布到私有仓库
```

当执行 ` pod repo push xxx xxx.podspec`  的时候 提示 下面错误

```
The repo `xxxxx` at `../../../../../.cocoapods/repos/xxxx is not clean 
```

```javascript
pod repo update [xxxx]
```

结果发现并不好使，我再想要不要删除本地的再次添加如何。

就执行下面的操作

```javascript
pod repo remove [xxxx]
```

执行完毕执行添加

```javascript
pod repo add [xxx] [xxx]
```



使用时 

1. 遇到 linker command failed with exit code 1 (use -v to see invocation)

   ` 在TARGETS → Build Settings → Enable Bitcode 设置为 NO`

2. 编译 成功 出现图片不显示 xib 不显示 

   ```
   s.resource = "CETVideoKit/**/*.{png,xib}"
   ```
