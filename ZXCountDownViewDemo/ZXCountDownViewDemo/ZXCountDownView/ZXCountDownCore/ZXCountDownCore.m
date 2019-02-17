//
//  ZXCountDownCore.m
//  ZXCountDownView
//
//  Created by 李兆祥 on 2019/2/15.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXCountDownCore.h"
#import "ZXCountDownDefine.h"
#import "NSDate+ZXCountDownTime.h"
#define ZXDocPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
@interface ZXCountDownCore()
@property(nonatomic,strong)dispatch_source_t timer;
@property(nonatomic,copy)NSString *mark;
@property(nonatomic,assign)BOOL didStart;
@property(nonatomic,assign)BOOL inRunLoop;
@property(nonatomic,assign)long countDownSec;
@property(nonatomic,assign)long timeout;
@property(nonatomic,assign)long orgCountDownSec;
@property(nonatomic,assign)long endTimestamp;
@property(nonatomic,strong)NSMutableDictionary *markDic;
@property(nonatomic,copy)countDownBlock resBlock;
@end
@implementation ZXCountDownCore
#pragma mark 开启倒计时
-(void)startCountDown{
    if(self.timer){
        if(!self.didStart){
            [self refMarkDic];
            self.endTimestamp = [NSDate getTimeStamp] + self.countDownSec;
            [self.markDic setValue:[NSNumber numberWithLong:self.endTimestamp] forKey:self.mark];
            [self arcObj:self.markDic pathComponent:ZXCountDownBtnMark];
            [self coreRunLoop];
            self.inRunLoop = YES;
           //dispatch_resume(self.timer);
        }
        self.didStart = YES;
    }else{
        [self reStartCountDown];
    }
}
#pragma mark 重新开启倒计时
-(void)reStartCountDown{
    [self stopCountDown];
    [self setCountDown:self.orgCountDownSec mark:self.mark resBlock:self.resBlock];
    [self startCountDown];
}

#pragma mark 停止倒计时
-(void)stopCountDown{
    [self invalidateTimer];
    [self refMarkDic];
    if([self.markDic.allKeys containsObject:self.mark ]){
        [self.markDic setValue:@0 forKey:self.mark];
        [self arcObj:self.markDic pathComponent:ZXCountDownBtnMark];
    }
}
#pragma mark 设置倒计时配置
-(void)setCountDown:(long)countDownSec mark:(NSString *)mark resBlock:(countDownBlock)resBlock{
    if(!mark)return;
    self.resBlock = resBlock;
    [self invalidateTimer];
    long disTime = [self getDisTimeWithMark:mark];
    if(!self.orgCountDownSec){
        self.orgCountDownSec = countDownSec;
    }
    if(disTime > 0 && !self.disableScheduleStore){
        countDownSec = disTime;
    }
    self.countDownSec = countDownSec;
    self.mark = mark;
    ZXCountDownWeakSelf;
    if (self.timer == nil) {
        self.timeout = countDownSec;
        if (self.timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC,  0);
            dispatch_source_set_event_handler(self.timer, ^{
                if(weakSelf.inRunLoop){
                    [weakSelf coreRunLoop];
                }
            });
        }
        dispatch_resume(self.timer);
        if(disTime > 0 && !self.disableScheduleStore){
            [self startCountDown];
        }
    }
}
-(void)coreRunLoop{
    if(self.timeout <= 0){
        [self invalidateTimer];
    }else {
        long timestamp = [NSDate getTimeStamp];
        if(self){
            self.timeout =  self.endTimestamp - timestamp < 0 ? 0 : self.endTimestamp - timestamp;
        }
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.resBlock(self.timeout);
    });
}
#pragma mark 关闭Timer
-(void)invalidateTimer{
    if(self.timer){
        dispatch_source_cancel(self.timer);
        self.inRunLoop = NO;
        self.timer = nil;
        self.didStart = NO;
    }
}

#pragma mark 刷新markDic，从沙盒中获取最新的markDic
-(void)refMarkDic{
    self.markDic = (NSMutableDictionary *)[self unArcObjPathComponent:ZXCountDownBtnMark];
}
#pragma mark -private
#pragma mark 获取距离结束时间
-(long)getDisTimeWithMark:(NSString *)mark{
    if([self.markDic.allKeys containsObject:mark]){
        long endTimestamp = [[self.markDic valueForKey:mark] longValue];
        long curTimestamp = [NSDate getTimeStamp];
        if(curTimestamp < endTimestamp){
            long disSec = endTimestamp - curTimestamp;
            return disSec;
        }
    }
    return 0;
}
#pragma mark 懒加载
-(NSMutableDictionary *)markDic{
    if(!_markDic){
        NSMutableDictionary *countDownMarkDic = (NSMutableDictionary *)[self unArcObjPathComponent:ZXCountDownBtnMark];
        if(!countDownMarkDic){
            countDownMarkDic = [NSMutableDictionary dictionary];
        }
        _markDic = [countDownMarkDic mutableCopy];
    }
    return _markDic;
}

#pragma mark 归档存储数据
-(void)arcObj:(id)obj pathComponent:(NSString *)pathComponent{
    [NSKeyedArchiver archiveRootObject:obj toFile:[ZXDocPath stringByAppendingPathComponent:pathComponent]];
}

#pragma mark 读档读取数据
-(instancetype)unArcObjPathComponent:(NSString *)pathComponent{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[ZXDocPath stringByAppendingPathComponent:pathComponent]];
}

@end
