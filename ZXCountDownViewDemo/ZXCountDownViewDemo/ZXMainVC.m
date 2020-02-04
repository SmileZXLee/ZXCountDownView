//
//  ViewController.m
//  ZXCountDownViewDemo
//
//  Created by 李兆祥 on 2019/2/15.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXMainVC.h"
#import "ZXCountDownView.h"
@interface ZXMainVC()
@property (weak, nonatomic) IBOutlet ZXCountDownLabel *scheduleStoreLabel;

@property (weak, nonatomic) IBOutlet ZXCountDownLabel *normalLabel;
@property (weak, nonatomic) IBOutlet ZXCountDownBtn *scheduleStoreBtn;
@property (weak, nonatomic) IBOutlet ZXAutoCountDownBtn *getCheckCodeBtn;
@property (weak, nonatomic) IBOutlet ZXAutoCountDownBtn *testBtn;

@end

@implementation ZXMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZXCountDownView";
    [self initScheduleStoreLabel];
    [self initNormalLabel];
    [self initScheduleStoreBtn];
    [self initGetCheckCodeBtn];
    [self initPureCBtn];
}

#pragma mark 初始化自动保存进度Label
-(void)initScheduleStoreLabel{
    __weak __typeof(self) weakSelf = self;
    [self.scheduleStoreLabel setCountDown:10 mark:@"ScheduleStoreLabel" resTextFormat:^NSString *(long remainSec) {
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
    self.normalLabel.disableResumeWhenEnd = YES;
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
    __weak __typeof(self) weakSelf = self;
    [self.getCheckCodeBtn enableAutoCountDown:20 mark:@"GetCheckCodeBtn" resTextFormat:^NSString *(long remainSec) {
        NSLog(@"%ld",remainSec);
        return [NSString stringWithFormat:@"%ld秒后重发",remainSec];
    }];
    self.testBtn.backgroundColor = [UIColor colorWithRed:3/255.0 green:139/255.0 blue:254/255.0 alpha:1];
    self.testBtn.disableResumeWhenEnd = YES;
    [self.testBtn enableAutoCountDown:20 mark:@"GetCheckCodeBtn" resTextFormat:^NSString *(long remainSec) {
        if(remainSec > 0){
            weakSelf.testBtn.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            return [NSString stringWithFormat:@"%ld秒后重发",remainSec];
        }else{
            weakSelf.testBtn.backgroundColor = [UIColor colorWithRed:3/255.0 green:139/255.0 blue:254/255.0 alpha:1];
            return [NSString stringWithFormat:@"重新发送"];
        }
    }];
    [self.testBtn addTarget:self action:@selector(pureCBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 初始化纯代码点击获取验证码Btn
-(void)initPureCBtn{
    return;
    ZXAutoCountDownBtn *countDownBtn = [[ZXAutoCountDownBtn alloc]init];
    countDownBtn.frame = CGRectMake(20, 250, 100, 20);
    
    countDownBtn.backgroundColor = [UIColor blueColor];
    [countDownBtn setTitle:@"纯代码按钮" forState:UIControlStateNormal];
    countDownBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [countDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [countDownBtn addTarget:self action:@selector(pureCBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    countDownBtn.disableResumeWhenEnd = YES;
    //[self.view addSubview:countDownBtn];
    
    [countDownBtn enableAutoCountDown:10 mark:@"GetPureCheckCodeBtn" resTextFormat:^NSString *(long remainSec) {
        return [NSString stringWithFormat:@"%ld秒后重发",remainSec];
    }];
    
    
}
#pragma mark -Action
-(void)pureCBtnAction:(ZXAutoCountDownBtn *)btn{
    //DoSomething
}
#pragma mark 点击了获取验证码按钮
- (IBAction)getCheckCodeAction:(id)sender {
    //判断如果手机号码不合法，可不触发倒计时
    if(0){
        self.getCheckCodeBtn.terminateCountDown = YES;
        return;
    }
    //如果需要过2秒再执行倒计时
    if(0){
        self.getCheckCodeBtn.terminateCountDown = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.getCheckCodeBtn startCountDown];
        });
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

- (IBAction)pauseAction:(id)sender {
    [self.scheduleStoreLabel pauseCountDown];
    [self.normalLabel pauseCountDown];
    [self.scheduleStoreBtn pauseCountDown];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
