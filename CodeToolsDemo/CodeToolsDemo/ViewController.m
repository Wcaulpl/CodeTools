//
//  ViewController.m
//  CodeToolsDemo
//
//  Created by CETzxy on 2018/12/14.
//  Copyright © 2018年 Wcaulpl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

XYPropStatementAndFuncStatement(weak, ViewController, XYAutoScrollLabel *, titleNav);
XYPropStatement(weak, XYAutoScrollLabel *, titleLabel);
//@property (nonatomic, weak) XYAutoScrollLabel *titleNav;
//@property (nonatomic, weak) XYAutoScrollLabel *titleLabel;
@property (nonatomic, weak) UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* 自定义导航 栏 */
    XYAutoScrollLabel *titleNav = [[XYAutoScrollLabel alloc] init];
    self.titleNav = titleNav;
    titleNav.text = @"导航自然title";
    titleNav.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleNav;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, 200, 300, 40)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.backView=view];
    
    XYViewCornerRadius(view, 20, UIRectCornerBottomRight|UIRectCornerBottomLeft);
    
    
    XYAutoScrollLabel *titleLabel = [[XYAutoScrollLabel alloc] initWithFrame:CGRectMake(30, 100, 300, 40)];
    self.titleLabel = titleLabel;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"label自然title";
    [self.view addSubview:self.titleLabel];
    
    [self.btn1 xy_locationAdjustWithMode:buttonModeTop spacing:10];
    [self.btn2 xy_locationAdjustWithMode:buttonModeLeft spacing:10];
    [self.btn3 xy_locationAdjustWithMode:buttonModeRight spacing:10];
    [self.btn4 xy_locationAdjustWithMode:buttonModeBottom spacing:10];
    
    self.checkBtn.clickInterval = 4;
    //    button1 xy_locationAdjustWi .hw_locationAdjust(buttonMode: .Top, spacing: 10)
    //    button1.hw_locationAdjust(buttonMode: .Left, spacing: 10)
    //    button2.hw_locationAdjust(buttonMode: .Right, spacing: 10)
    //    button3.hw_locationAdjust(buttonMode: .Bottom, spacing: 10)
    
    
}

- (IBAction)changeNav:(UIButton *)sender {
    if ([self.titleNav.text isEqualToString:@"导航自然title"]) {
        self.titleNav.text = @"导航滚动title: 这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长的一段文字";
        XYViewCornerRadius(self.backView, 20, UIRectCornerTopLeft|UIRectCornerTopRight);
        NSString *str = @"导航滚动title: 这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长的一段文字".aes256Encrypt;
        XYLog(@"加密 :%@", str);
        
        XYLog(@"解密 :%@", str.aes256Decrypt);
    } else {
        self.titleNav.text = @"导航自然title";
        XYViewCornerRadius(self.backView, 20, UIRectCornerBottomRight|UIRectCornerBottomLeft);
    }
}

- (IBAction)changeLabel:(UIButton *)sender {
    if ([self.titleLabel.text isEqualToString:@"label自然title"]) {
        self.titleLabel.text = @"label滚动title: 这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长的一段文字";
        NSString *str = @"label滚动title: 这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长的一段文字". aes256Encrypt;
        XYLog(@"加密 :%@", str);
        
        XYLog(@"解密 :%@", str.aes256Decrypt);
    } else {
        self.titleLabel.text = @"label自然title";
    }
}


@end
