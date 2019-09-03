//
//  ZXAutoCountDownBtn.m
//  ZXCountDownView
//
//  Created by 李兆祥 on 2019/2/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCountDownView

#import "ZXAutoCountDownBtn.h"
#import "ZXCountDownDefine.h"
#import "ZXCountDownCore.h"
@interface ZXAutoCountDownBtn()
@property(nonatomic,copy)NSString *countDownMark;
@property(nonatomic,assign)NSUInteger countDownSec;
@property(nonatomic,assign)BOOL enAbleAutoCountDown;
@property(nonatomic,copy)textFormatBlock textFormat;
@end
@implementation ZXAutoCountDownBtn
-(void)initOpr{
    [super initOpr];
}
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [super sendAction:action to:target forEvent:event];
    if(!self.terminateCountDown){
        [self startCountDown];
    }
    self.terminateCountDown = NO;
}

-(void)startCountDown{
    if(self.enabled){
        ZXCountDownWeakSelf;
        [self setCountDown:self.countDownSec mark:self.countDownMark resTextFormat:^NSString *(long remainSec) {
            if(remainSec > 0){
                weakSelf.enabled = NO;
            }else{
                weakSelf.enabled = YES;
            }
            if(weakSelf){
                return weakSelf.textFormat(remainSec);
            }else{
                return nil;
            }
        }];
        [super startCountDown];
    }
}
-(void)enableAutoCountDown:(long)countDownSec mark:(NSString *)mark resTextFormat:(textFormatBlock)textFormat{
    self.countDownMark = mark;
    self.countDownSec = countDownSec;
    self.enAbleAutoCountDown = YES;
    self.textFormat = textFormat;
    
    ZXCountDownCore *core = [[ZXCountDownCore alloc]init];
    long disTime = [core getDisTimeWithMark:mark];
    if(disTime > 0 && !self.disableScheduleStore){
        [self startCountDown];
    }
}
-(void)resume{
    [self stopCountDown];
    self.enabled = YES;
    [self setTitle:[self valueForKey:@"orgText"] forState:UIControlStateNormal];
    [self setTitleColor:[self valueForKey:@"orgTextColor"] forState:UIControlStateNormal];
    self.backgroundColor = [self valueForKey:@"orgBacColor"];
}
-(void)dealloc{
    [self invalidateTimer];
}
@end
