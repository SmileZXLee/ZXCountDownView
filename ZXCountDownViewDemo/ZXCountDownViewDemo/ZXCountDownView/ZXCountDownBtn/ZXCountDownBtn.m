//
//  ZXCountDownBtn.m
//  ZXCountDownViewDemo
//
//  Created by 李兆祥 on 2019/2/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXCountDownBtn.h"
#import "ZXCountDownCore.h"
#import "ZXCountDownDefine.h"
@interface ZXCountDownBtn()
@property(nonatomic,copy)NSString *orgText;
@property(nonatomic,strong)UIColor *orgTextColor;
@property(nonatomic,strong)UIColor *orgBacColor;
@property(nonatomic,strong)ZXCountDownCore *cdCore;
@end
@implementation ZXCountDownBtn
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
    self.orgText = self.currentTitle;
    self.orgTextColor = self.titleLabel.textColor;
    self.orgBacColor = self.backgroundColor;
}
-(void)setCountDown:(long)countDownSec mark:(NSString *)mark resTextFormat:(textFormatBlock)textFormat{
    self.cdCore = [[ZXCountDownCore alloc]init];
    self.cdCore.disableScheduleStore = self.disableScheduleStore;
    ZXCountDownWeakSelf;
    [self.cdCore setCountDown:countDownSec mark:mark resBlock:^(long remainSec) {
        NSString *btnTitle = textFormat(remainSec);
        if(remainSec > 0){
            [weakSelf setTitle:btnTitle forState:UIControlStateNormal];
        }else{
            [weakSelf setTitle:weakSelf.orgText forState:UIControlStateNormal];
            [weakSelf setTitleColor:weakSelf.orgTextColor forState:UIControlStateNormal];
            weakSelf.backgroundColor = weakSelf.orgBacColor;
        }
    }];
}
-(void)resumeOrgStatus{
    [self setTitle:self.orgText forState:UIControlStateNormal];
    [self setTitleColor:self.orgTextColor forState:UIControlStateNormal];
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
