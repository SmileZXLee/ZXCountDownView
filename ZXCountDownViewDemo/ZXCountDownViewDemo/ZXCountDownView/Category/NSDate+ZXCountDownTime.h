//
//  NSDate+ZXCountDownTime.h
//  ZXCountDownView
//
//  Created by 李兆祥 on 2019/2/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCountDownView

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ZXCountDownTime)
///获取当前时间时间戳
+(long)getTimeStamp;
///将秒转为时间格式
+(NSString *)getDateStrWithSec:(long)sec dateFormat:(NSString *)dateFormat;
@end

NS_ASSUME_NONNULL_END
