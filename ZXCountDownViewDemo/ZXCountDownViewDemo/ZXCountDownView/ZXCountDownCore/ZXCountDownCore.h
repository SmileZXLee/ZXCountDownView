//
//  ZXCountDownCore.h
//  ZXCountDownView
//
//  Created by 李兆祥 on 2019/2/15.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCountDownView

#import <Foundation/Foundation.h>
typedef enum {
    ZXCountViewStatusEnded = 0x00,    // 倒计时View倒计时未开始或已结束
    ZXCountViewStatusPaused = 0x01,    // 倒计时View已暂停
    ZXCountViewStatusRunning = 0x02,    // 倒计时View正在倒计时
}ZXCountViewStatus;
typedef void(^countDownBlock) (long remainSec);
NS_ASSUME_NONNULL_BEGIN
@interface ZXCountDownCore : NSObject
///是否不存储倒计时进度，默认为否
@property(nonatomic,assign)BOOL disableScheduleStore;
///倒计时View当前状态
@property(nonatomic,assign,readonly)ZXCountViewStatus countViewStatus;
///设置倒计时时间，倒计时标志，并回调block，ZXCountDown依据mark来分别存储不同倒计时任务剩余的倒计时时间
-(void)setCountDown:(long)countDownSec mark:(NSString *)mark resBlock:(countDownBlock)resBlock;
///开始倒计时
-(void)startCountDown;
//暂停倒计时
-(void)pauseCountDown;
///重新开始倒计时
-(void)reStartCountDown;
///结束倒计时
-(void)stopCountDown;
///通过mark获取剩余倒计时时间
///关闭倒计时
-(void)invalidateTimer;
///获取距离结束时间
-(long)getDisTimeWithMark:(NSString *)mark;
@end

NS_ASSUME_NONNULL_END
