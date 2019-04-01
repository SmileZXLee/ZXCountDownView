//
//  NSDate+ZXCountDownTime.m
//  ZXCountDownView
//
//  Created by 李兆祥 on 2019/2/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCountDownView

#import "NSDate+ZXCountDownTime.h"

@implementation NSDate (ZXCountDownTime)
+(long)getTimeStamp{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    return (long)[date timeIntervalSince1970];
}
+(NSString *)getDateStrWithSec:(long)sec dateFormat:(NSString *)dateFormat{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sec];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.timeZone = zone;
    [dateformatter setDateFormat:dateFormat];
    return [dateformatter stringFromDate:date];
}
@end
