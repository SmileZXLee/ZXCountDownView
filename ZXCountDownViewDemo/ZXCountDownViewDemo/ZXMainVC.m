//
//  ViewController.m
//  ZXCountDownViewDemo
//
//  Created by 李兆祥 on 2019/2/15.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXMainVC.h"
#import "ZXCountDownHeaders.h"
@interface ZXMainVC()
@property (weak, nonatomic) IBOutlet ZXCountDownLabel *scheduleStoreLabel;

@property (weak, nonatomic) IBOutlet ZXCountDownLabel *normalLabel;
@property (weak, nonatomic) IBOutlet ZXCountDownBtn *scheduleStoreBtn;
@property (weak, nonatomic) IBOutlet ZXAutoCountDownBtn *getCheckCodeBtn;

@end

@implementation ZXMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZXCountDownView";
    [self initScheduleStoreLabel];
    [self initNormalLabel];
    [self initScheduleStoreBtn];
    [self initGetCheckCodeBtn];
}

#pragma mark 初始化自动保存进度Label
-(void)initScheduleStoreLabel{
    ZXCountDownWeakSelf;
    [self.scheduleStoreLabel setCountDown:40 mark:@"ScheduleStoreLabel" resTextFormat:^NSString *(long remainSec) {
        if(remainSec > 30){
            weakSelf.scheduleStoreLabel.backgroundColor = [UIColor orangeColor];
        }else{
            weakSelf.scheduleStoreLabel.backgroundColor = [UIColor redColor];
        }
        return [NSString stringWithFormat:@"%ld",remainSec];
    }];
}

#pragma mark 初始化不自动保存进度Label
-(void)initNormalLabel{
    self.normalLabel.disableScheduleStore = YES;
    [self.normalLabel setCountDown:20 mark:@"NormalLabel" resTextFormat:^NSString *(long remainSec) {
        if(remainSec > 10){
            return [NSString stringWithFormat:@"还有%ld秒",remainSec];
        }else{
            return [NSString stringWithFormat:@"只有%ld秒",remainSec];
        }
    }];
}

#pragma mark 初始化自动保存进度Btn
-(void)initScheduleStoreBtn{
    [self.scheduleStoreBtn setCountDown:1000 mark:@"ScheduleStoreBtn" resTextFormat:^NSString *(long remainSec) {
        NSString *timeformatStr = [NSDate getDateStrWithSec:remainSec dateFormat:@"mm分ss秒"];
        return [NSString stringWithFormat:@"%@",timeformatStr];
    }];
}

#pragma mark 初始化点击获取验证码Btn
-(void)initGetCheckCodeBtn{
    [self.getCheckCodeBtn enableAutoCountDown:20 mark:@"GetCheckCodeBtn" resTextFormat:^NSString *(long remainSec) {
        return [NSString stringWithFormat:@"%ld秒后重发",remainSec];
    }];
}
#pragma mark -Action

#pragma mark 点击了获取验证码按钮
- (IBAction)getCheckCodeAction:(id)sender {
    //判断如果手机号码不合法，可不触发倒计时
    if(0){
        self.getCheckCodeBtn.start = NO;
        return;
    }
    NSLog(@"执行获取验证码操作!!");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //判断如果验证码请求失败，可重置倒计时按钮
        if(0){
            [self.getCheckCodeBtn resume];
        }
    });
}

#pragma mark 点击了开始倒计时按钮
- (IBAction)startAction:(id)sender {
    [self.scheduleStoreLabel startCountDown];
    [self.normalLabel startCountDown];
    [self.scheduleStoreBtn startCountDown];
}
#pragma mark 点击了结束倒计时按钮
- (IBAction)stopAction:(id)sender {
    [self.scheduleStoreLabel stopCountDown];
    [self.normalLabel stopCountDown];
    [self.scheduleStoreBtn stopCountDown];
}

#pragma mark 点击了重置按钮
- (IBAction)resetAction:(id)sender {
    [self.scheduleStoreLabel reStartCountDown];
    [self.normalLabel reStartCountDown];
    [self.scheduleStoreBtn reStartCountDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
