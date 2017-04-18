//
//  IDCountDownButton.m
//  验证码倒计时
//
//  Created by 胡正康 on 2017/4/6.
//  Copyright © 2017年 胡正康. All rights reserved.
//

#import "IDCountDownButton.h"
@interface IDCountDownButton ()
/** 保存倒计时按钮的非倒计时状态的title */
@property (nonatomic, copy) NSString *originalTitle;
/** 保存倒计时的时长 */
@property (nonatomic, assign) NSInteger tempDurationOfCountDown;
/** 定时器对象 */
@property (nonatomic, strong) NSTimer *countDownTimer;
@end
@implementation IDCountDownButton

/**
 重写setter
 title属性的setter
 1）、私有属性originalTitle用来暂存开始计时前button的标题，即用户设置的button的标题，通常是“获取验证码”
 2）、需要屏蔽计时过程中，title更新时改变originalTitle的值
 
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    // 倒计时过程中title的改变不更新originalTitle
    if (self.tempDurationOfCountDown == self.durationOfCountDown) {
        self.originalTitle = title;
    }
}

/**
 durationOfCountDown属性的setter
 1）、设置tempDurationOfCountDown的值
 2）、tempDurationOfCountDown的作用：倒计时；与durationOfCountDown配合判断当前IDCountDownButton是否具备重新开始倒计时的能力
 */
- (void)setDurationOfCountDown:(NSInteger)durationOfCountDown {
    _durationOfCountDown = durationOfCountDown;
    self.tempDurationOfCountDown = _durationOfCountDown;
}

/**
 初始化
 1）、设置倒计时的默认时长为60妙
 2）、设置IDCountDownButton默认的title为“获取验证码”
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置默认的倒计时时长为60秒
        self.durationOfCountDown = 60;
        // 设置button的默认标题为“获取验证码”
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // 设置默认的倒计时时长为60秒
        self.durationOfCountDown = 60;
        // 设置button的默认标题为“获取验证码”
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}
/**
 拦截IDCountDownButton的点击事件，判断是否开始倒计时
 1）、若tempDurationOfCountDown等于durationOfCountDown，说明未开始倒计时，响应并传递IDCountDownButton的点击事件；否则，不响应且不传递。
 */
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // 若正在倒计时，不响应点击事件
    if (self.tempDurationOfCountDown != self.durationOfCountDown) {
        return NO;
    }
    // 若未开始倒计时，响应并传递点击事件，开始倒计时
    [self startCountDown];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

/** 倒计时
     1）、创建定时器，开始倒计时
 */
- (void)startCountDown {
    // 创建定时器
    self.countDownTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateIDCountDownButtonTitle) userInfo:nil repeats:YES];
    // 将定时器添加到当前的RunLoop中（自动开启定时器）
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
}
/**  2）、更新IDCountDownButton的title为倒计时剩余的时间 */
- (void)updateIDCountDownButtonTitle {
    if (self.tempDurationOfCountDown == 0) {
        // 设置IDCountDownButton的title为开始倒计时前的title
        [self setTitle:self.originalTitle forState:UIControlStateNormal];
        // 恢复IDCountDownButton开始倒计时的能力
        self.tempDurationOfCountDown = self.durationOfCountDown;
        [self.countDownTimer invalidate];
    } else {
        // 设置IDCountDownButton的title为当前倒计时剩余的时间
        [self setTitle:[NSString stringWithFormat:@"%zd秒后重新发送", self.tempDurationOfCountDown--] forState:UIControlStateNormal];
    }
}
 /**  3）、移除定时器 */
- (void)dealloc {
    [self.countDownTimer invalidate];
}
@end
