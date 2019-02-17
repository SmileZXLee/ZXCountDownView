//
//  ZXCountDownLabel.m
//  ZXCountDownViewDemo
//
//  Created by 李兆祥 on 2019/2/15.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXCountDownLabel.h"
#import "ZXCountDownCore.h"
#import "ZXCountDownDefine.h"
@interface ZXCountDownLabel()
@property(nonatomic,copy)NSString *orgText;
@property(nonatomic,strong)UIColor *orgTextColor;
@property(nonatomic,strong)UIColor *orgBacColor;
@property(nonatomic,strong)ZXCountDownCore *cdCore;
@end
@implementation ZXCountDownLabel

- (instancetype)init{
    if(self = [super init]) {
        [self initOpr];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initOpr];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initOpr];
}

-(void)initOpr{
    self.orgText = self.text;
    self.orgTextColor = self.textColor;
    self.orgBacColor = self.backgroundColor;
}

-(void)setCountDown:(long)countDownSec mark:(NSString *)mark resTextFormat:(textFormatBlock)textFormat{
    self.cdCore = [[ZXCountDownCore alloc]init];
    self.cdCore.disableScheduleStore = self.disableScheduleStore;
    ZXCountDownWeakSelf;
    [self.cdCore setCountDown:countDownSec mark:mark resBlock:^(long remainSec) {
        weakSelf.text = textFormat(remainSec);
        if(!(remainSec > 0)){
            [weakSelf resumeOrgStatus];
        }
    }];
}

-(void)resumeOrgStatus{
    self.text = self.orgText;
    self.textColor = self.orgTextColor;
    self.backgroundColor = self.orgBacColor;
}
-(void)startCountDown{
    [self.cdCore startCountDown];
}
-(void)reStartCountDown{
    [self.cdCore reStartCountDown];
}
-(void)stopCountDown{
    [self.cdCore stopCountDown];
}
-(void)invalidateTimer{
    [self.cdCore invalidateTimer];
}
-(void)dealloc{
    [self invalidateTimer];
}
@end
