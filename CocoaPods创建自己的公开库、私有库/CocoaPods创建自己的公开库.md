### CocoaPods创建自己的公开库

1. **注册Trunk** 

   - runk需要CocoaPods 0.33版本以上  用`pod --version` 命令查看版本
   如果版本低，需要升级：
   ```
   sudo gen install cocoapods
   pod setup
   ```
    - 查看自己是否注册过Trunk ` pod trunk me`

      - 如果没有注册过

        ![1545100579803](/Users/cetzxy/Desktop/CodeTools/CocoaPods创建自己的公开库、私有库/1545100579803.jpg)

      - 注册

         ```
         - pod trunk register slzxy14@163.com "Wcaulpl" --verbose
         
          "Wcaulpl" 里面代表你的用户名，最好起一个好的名字
          slzxy14@163.com 代表你的邮箱
         ```

      - 注册成功后可以再查看一下个人信息pod trunk me
        ![1545100993485](/Users/cetzxy/Desktop/CodeTools/CocoaPods创建自己的公开库、私有库/1545100993485.jpg)
  2. **创建一个项目**

    - GitHub 上创建一个项目![1545112933774](/Users/cetzxy/Desktop/CodeTools/CocoaPods创建自己的公开库、私有库/1545112933774.jpg)
   - 将项目clone 下来，并添加 代码文件![1545114894849](/Users/cetzxy/Desktop/CodeTools/CocoaPods创建自己的公开库、私有库/1545114894849.jpg)
  3. **创建编辑.podspec**

    1. cd 到你的项目下
       ```
         //  XYAutoScrollLabel 这个是你框架的名称
         2、pod spec create XYAutoScrollLabel
       ```

    2. 编辑.podspec
      ```
     Pod::Spec.new do |s|
        s.name         = "XYAutoScrollLabel"  #名称，pod search 搜索的关键词,注意这里一定要和.podspec的名称一样,否则报错
        s.version      = "0.0.1" #版本号
        s.summary      = "一个文本超出文本框时自动滚动显示 的开源控件" #简介
        s.description  = <<-DESC DESC
        s.homepage     = "https://github.com/Wcaulpl/XYAutoScrollLabel" #项目主页地址
        s.license      = { :type => "MIT", :file => "FILE_LICENSE" } #许可证
        s.author             = { "Wcaulpl" => "slzxy14@163.com" } #作者
        s.source       = { :git => "https://github.com/Wcaulpl/XYAutoScrollLabel.git", :tag => "#{s.version}" } #项目的地址
        s.source_files  = "XYAutoScrollLabel", "XYAutoScrollLabel/*.{h,m}" #需要包含的源文件
        s.public_header_files = "XYAutoScrollLabel/XYAutoScrollLabel.h" #公开的头文件
        s.resources: 资源文件
        s.dependency：依赖库，不能依赖未发布的库，可以写多个依赖库
      ```

4. **上传git 并 打tag**
  ​     将包含配置好的 .podspec, LICENSE 的项目提交 Git

      //为git打tag
      git tag "0.0.1" 
      //将tag推送到远程仓库
      git push --tags
 5. **验证.podspec文件**

    ```
       pod spec lint XYAutoScrollLabel.podspec --verbose
       pod lib lint --allow-warnings // 出现警告
    ```

  6. **发布**
   ```
发布时会验证 Pod 的有效性，如果你在手动验证 Pod 时使用了 --use-libraries 或 --allow-warnings 等修饰符，那么发布的时候也应该使用相同的字段修饰，否则出现相同的报错。
   // --use-libraries --allow-warnings
   pod trunk push XYAutoScrollLabel.podspec
   ```
**出现这种情况就说明你发布成功了，等待人家审核就行了**

![1545119099543](/Users/cetzxy/Desktop/CodeTools/CocoaPods创建自己的公开库、私有库/1545119099543.jpg)

**验证仓库` pod search XYAutoScrollLabel ` 或 ` pod trunk me` ** 
