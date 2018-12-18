//
//  ViewController.m
//  CodeToolsDemo
//
//  Created by CETzxy on 2018/12/14.
//  Copyright © 2018年 Wcaulpl. All rights reserved.
//

#import "ViewController.h"
#import "XYDateAttribute.h"

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

XYPropSetFuncImplementation(ViewController, XYAutoScrollLabel *, titleNav)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *str = @"导航滚动title: 这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长的一段文字".aes256Encrypt;
    XYLog(@"加密 :%@", str);
    
    XYLog(@"解密 :%@", str.aes256Decrypt);
    
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
    
    [self getDate];
}

- (void)getDate {
    XYDateAttribute *datea = [[XYDateAttribute alloc] init];
    datea.xy_Date = @"2018-12-17";
    NSDate *date = [NSDate date];
    XYLog(@"是否今天: %d == %d ", datea.HYC_isToday ,date.xy_isToday);
    XYLog(@"英文星期: %@ == %@",datea.HYC_EnglishWeek, date.xy_englishWeek);//
    XYLog(@"时间戳: %@ == %f",datea.HYC_Date, date.xy_timeInterval);//
    XYLog(@"公历年: %@ == %ld",datea.HYC_GLYears, date.xy_year);//
    XYLog(@"公历月: %@ == %ld",datea.HYC_GLMonth, date.xy_month);//
    XYLog(@"公历日: %@ == %ld",datea.HYC_GLDay, date.xy_day);//
    
    
    XYLog(@"农历年: %@ == %@",datea.HYC_NLYears, date.xy_nlYear);//
    XYLog(@"农历月: %@ == %@",datea.HYC_NLMonth, date.xy_nlMonth);//
    XYLog(@"农历日: %@ == %@",datea.HYC_NLDay, date.xy_nlDay);//
    XYLog(@"中文星期: %@ == %@", datea.HYC_ChineseWeek, date.xy_chineseWeek);//

    
    XYLog(@"节气: %@ == %@",datea.HYC_SolarTerms, date.xy_solarTerms);//
    XYLog(@"公历节日: %@ == %@",datea.HYC_GLHoliday, date.xy_holiday);//
    XYLog(@"农历节日: %@ == %@",datea.HYC_NLHoliday, date.xy_nlHoliday);//

}

- (IBAction)changeNav:(UIButton *)sender {
    if ([self.titleNav.text isEqualToString:@"导航自然title"]) {
        self.titleNav.text = @"导航滚动title: 这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长的一段文字";
        XYViewCornerRadius(self.backView, 20, UIRectCornerTopLeft|UIRectCornerTopRight);
    } else {
        self.titleNav.text = @"导航自然title";
        XYViewCornerRadius(self.backView, 20, UIRectCornerBottomRight|UIRectCornerBottomLeft);
    }
}

- (IBAction)changeLabel:(UIButton *)sender {
    if ([self.titleLabel.text isEqualToString:@"label自然title"]) {
        self.titleLabel.text = @"label滚动title: 这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长的一段文字";
        NSString *str = @"label滚动title: 这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长的一段文字".aes256Encrypt;
        XYLog(@"加密 :%@", str);
        XYLog(@"解密 :%@", str.aes256Decrypt);
    } else {
        self.titleLabel.text = @"label自然title";
    }
}


@end
