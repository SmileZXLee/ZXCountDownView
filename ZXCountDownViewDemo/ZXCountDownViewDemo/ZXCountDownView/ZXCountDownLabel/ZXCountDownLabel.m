//
//  ZXCountDownLabel.m
//  ZXCountDownView
//
//  Created by 李兆祥 on 2019/2/15.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCountDownView

#import "ZXCountDownLabel.h"
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.orgText = !self.orgText ? self.text : self.orgText;
        self.orgTextColor = !self.orgTextColor ? self.textColor : self.orgTextColor;
        self.orgBacColor = !self.orgBacColor ? self.backgroundColor : self.orgBacColor;
    });
}

-(void)setCountDown:(long)countDownSec mark:(NSString *)mark resTextFormat:(textFormatBlock)textFormat{
    self.cdCore = [[ZXCountDownCore alloc]init];
    self.cdCore.disableScheduleStore = self.disableScheduleStore;
    ZXCountDownWeakSelf;
    [self.cdCore setCountDown:countDownSec mark:mark resBlock:^(long remainSec) {
        NSString *labelTitle;
        if(textFormat){
            labelTitle = textFormat(remainSec);
        }else{
            labelTitle = [NSString stringWithFormat:@"%ld",remainSec];
        }
        if(remainSec > 0){
            weakSelf.text = labelTitle;
        }else{
            if(weakSelf.disableResumeWhenEnd){
                weakSelf.text = labelTitle;
                return;
            }
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
