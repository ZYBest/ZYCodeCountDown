//
//  ViewController.m
//  验证码倒计时
//
//  Created by 胡正康 on 2017/4/6.
//  Copyright © 2017年 胡正康. All rights reserved.
//

#import "ViewController.h"
#import "IDCountDownButton.h"
@interface ViewController ()
/** 验证码倒计时的button */
@property (nonatomic, strong) IDCountDownButton *vertificationCodeIDCountDownButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatMainBtn];
}
#pragma mark --- 初始化button
-(void)creatMainBtn{
    // 创建vertificationCodeIDCountDownButton
    self.vertificationCodeIDCountDownButton = [[IDCountDownButton alloc] initWithFrame:CGRectMake(160, 204, 120, 44)];
    // 添加点击事件
    [self.vertificationCodeIDCountDownButton addTarget:self action:@selector(vertificationCodeIDCountDownButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    // 设置标题相关属性
    [self.vertificationCodeIDCountDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.vertificationCodeIDCountDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    // 设置背景色
    [self.vertificationCodeIDCountDownButton setBackgroundColor:[UIColor redColor]];
    // 设置倒计时时长
    self.vertificationCodeIDCountDownButton.durationOfCountDown = 60;
    [self.vertificationCodeIDCountDownButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    // 将vertificationCodeIDCountDownButton添加的控制器的view中
    [self.view addSubview:self.vertificationCodeIDCountDownButton];
}


- (void)vertificationCodeIDCountDownButtonClick:(UIButton *)button {
    // TODO：调用服务器接口，获取验证码
}



@end
