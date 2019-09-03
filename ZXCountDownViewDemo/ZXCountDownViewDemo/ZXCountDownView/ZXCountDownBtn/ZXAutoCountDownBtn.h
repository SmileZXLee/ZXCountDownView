//
//  ZXAutoCountDownBtn.h
//  ZXCountDownView
//
//  Created by 李兆祥 on 2019/2/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCountDownView

#import <UIKit/UIKit.h>
#import "ZXCountDownBtn.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZXAutoCountDownBtn : ZXCountDownBtn
///启用自动倒计时按钮，实现类似点击获取验证码效果，countDownSec为倒计时时间，mark为ZXCountDownView用于区分不同倒计时操作的标识，并回调结果
-(void)enableAutoCountDown:(long)countDownSec mark:(NSString *)mark resTextFormat:(textFormatBlock)textFormat;
///是否终止倒计时，默认为否(每次点击倒计时按钮仅终止这一次的操作，如希望点击倒计时按钮均不执行自动倒计时，请使用ZXCountDownBtn)
@property(nonatomic,assign)BOOL terminateCountDown;
///重置倒计时按钮
-(void)resume;
@end

NS_ASSUME_NONNULL_END
