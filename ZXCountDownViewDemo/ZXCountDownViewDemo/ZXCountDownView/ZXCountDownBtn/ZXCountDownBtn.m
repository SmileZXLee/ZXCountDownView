//
//  ZXCountDownBtn.m
//  ZXCountDownView
//
//  Created by 李兆祥 on 2019/2/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCountDownView

#import "ZXCountDownBtn.h"
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
    [self initOpr];
    [super awakeFromNib];
    
}

-(void)initOpr{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.orgText = !self.orgText ? self.currentTitle : self.orgText;
        self.orgTextColor = !self.orgTextColor ? self.titleLabel.textColor : self.orgTextColor;
        self.orgBacColor = !self.orgBacColor ? self.backgroundColor : self.orgBacColor;
    });
}
-(void)setCountDown:(long)countDownSec mark:(NSString *)mark resTextFormat:(textFormatBlock)textFormat{
    self.cdCore = [[ZXCountDownCore alloc]init];
    self.cdCore.disableScheduleStore = self.disableScheduleStore;
    ZXCountDownWeakSelf;
    [self.cdCore setCountDown:countDownSec mark:mark resBlock:^(long remainSec) {
        NSString *btnTitle;
        if(textFormat){
            btnTitle = textFormat(remainSec);
        }else{
            btnTitle = [NSString stringWithFormat:@"%ld",remainSec];
        }
        if(remainSec > 0){
            [weakSelf setTitle:btnTitle forState:UIControlStateNormal];
        }else{
            if(weakSelf.disableResumeWhenEnd){
                [weakSelf setTitle:btnTitle forState:UIControlStateNormal];
                return;
            }
            [weakSelf resumeOrgStatus];
        }
    }];
}
-(void)resumeOrgStatus{
    [self setTitle:self.orgText forState:UIControlStateNormal];
    [self setTitleColor:self.orgTextColor forState:UIControlStateNormal];
    self.backgroundColor = self.orgBacColor;
}
-(void)startCountDown{
    [self initOpr];
    [self.cdCore startCountDown];
}
-(void)pauseCountDown{
    [self.cdCore pauseCountDown];
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

- (ZXCountViewStatus)countViewStatus{
    return self.cdCore.countViewStatus;
}
@end
