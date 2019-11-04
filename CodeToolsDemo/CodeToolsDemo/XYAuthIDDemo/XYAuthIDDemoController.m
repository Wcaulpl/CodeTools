//
//  XYAuthIDDemoController.m
//  CodeToolsDemo
//
//  Created by CETzxy on 2018/12/29.
//  Copyright © 2018年 Wcaulpl. All rights reserved.
//

#import "XYAuthIDDemoController.h"
#import "XYAuthID.h"
@interface XYAuthIDDemoController ()

@property (nonatomic, weak) UILabel *hintLabel;           // 提示标题
@property (nonatomic, weak) UIImageView *imageView;       // 图标
@property (nonatomic, weak) UIButton *actionBtn;          // 按钮

@property (nonatomic, copy) NSString *authImage;            // 认证图标名
@property (nonatomic, copy) NSString *authName;             // 认证名称

@end

@implementation XYAuthIDDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
}

- (void)setupUI {
    // 设置值
    if(iPhoneXSeries){
        self.authImage = @"auth_face";
        self.authName = @"面容";
    }else{
        self.authImage = @"auth_finger";
        self.authName = @"指纹";
    }
    
    // 添加组件
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 60)];
    hintLabel.font = [UIFont systemFontOfSize:22.f];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.numberOfLines = 0;
    hintLabel.text = [NSString stringWithFormat:@"XYAuth\n验证%@以进行登录", self.authName];
    [self.view addSubview:self.hintLabel=hintLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 35, self.hintLabel.frame.origin.y + 130, 70, 70)];
    imageView.image = [UIImage imageNamed:self.authImage];
    [self.view addSubview:self.imageView=imageView];
    
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    actionBtn.frame = CGRectMake(60, self.imageView.frame.origin.y + 190, self.view.frame.size.width - 120, 40);
    [actionBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    actionBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [actionBtn setTitle:[NSString stringWithFormat:@"点击验证%@", self.authName] forState:UIControlStateNormal];
    [actionBtn setBackgroundColor:[UIColor colorWithRed:123/255.f green:188/255.f blue:231/255.f alpha:1]];
    actionBtn.layer.cornerRadius = 5.f;
    actionBtn.layer.masksToBounds = YES;
    [actionBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.actionBtn=actionBtn];
    
    // 开始认证
    [self authVerification];
}

#pragma mark - 按钮点击事件
- (void)btnClicked:(UIButton *)sender {
    // 唤起指纹、面容ID验证
    [self authVerification];
}

#pragma mark - 验证TouchID/FaceID
- (void)authVerification {
    [XYAuthID xy_showAuthIDFinished:^(XYAuthIDState state, NSError * _Nonnull error) {
        if (state == XYAuthIDStateNotSupport) { // 不支持TouchID/FaceID
            NSLog(@"对不起，当前设备不支持指纹/面容ID");
        } else if(state == XYAuthIDStateFail) { // 认证失败
            NSLog(@"指纹/面容ID不正确，认证失败");
        } else if(state == XYAuthIDStateTouchIDLockout) {   // 多次错误，已被锁定
            NSLog(@"多次错误，指纹/面容ID已被锁定，请到手机解锁界面输入密码");
        } else if (state == XYAuthIDStateSuccess) { // TouchID/FaceID验证成功
            NSLog(@"认证成功！");
        }
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
