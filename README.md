# ZXCountDownView
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/SmileZXLee/ZXCountDownView/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/ZXCountDownView.svg?style=flat)](http://cocoapods.org/?q=ZXCountDownView)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/ZXCountDownView.svg?style=flat)](http://cocoapods.org/?q=ZXCountDownView)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208.0%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
## 安装
### 通过CocoaPods安装
```ruby
pod 'ZXCountDownView'
```
### 手动导入
* 将ZXCountDownView拖入项目中。

### 导入头文件
```objective-c
#import "ZXCountDownView.h"
```
***

## 效果图
![Image text](http://www.zxlee.cn/ZXCountDownViewDemo3.gif) 

***

## Demo
### ZXCountDownLabel
* 设置一个倒计时Label，且自动记录倒计时进度：
```objective-c
//第一个参数40即为倒计时时间为40秒，第二个参数mark用于标记区分当前倒计时任务和其他倒计时任务，确保与其他任务不重名即可，block第一个参数即为剩余秒数，block返回值即为显示在Label上的文字。(此处实现了一个倒计时40秒，且显示”还剩40、39、38...秒哦“的Label)
[self.scheduleStoreLabel setCountDown:40 mark:@"ScheduleStoreLabel" resTextFormat:^NSString *(long remainSec) {
    if(remainSec > 30){
        weakSelf.scheduleStoreLabel.backgroundColor = [UIColor orangeColor];
    }else{
        weakSelf.scheduleStoreLabel.backgroundColor = [UIColor redColor];
    }
    //显示剩余几分几秒
    NSString *timeformatStr = [NSDate getDateStrWithSec:remainSec dateFormat:@"mm分ss秒"];
    return timeformatStr;
}];
```
* 开始倒计时
```objective-c
[self.scheduleStoreLabel startCountDown];
```

### ZXCountDownBtn
* 与ZXCountDownLabel类似
### ZXAutoCountDownBtn
* 设置一个点击获取验证码的Button，且点击后自动开启倒计时，重启App后仍然保持倒计时进度：
```objective-c
//此处实现了一个倒计时20秒，且显示“还剩20、19、18...秒后重试”的Btn，且退出重新进入当前控制器或重启App不受影响。
[self.getCheckCodeBtn enableAutoCountDown:20 mark:@"GetCheckCodeBtn" resTextFormat:^NSString *(long remainSec) {
    return [NSString stringWithFormat:@"%ld秒后重发",remainSec];
}];
```
```objective-c
#pragma mark 点击了获取验证码按钮
- (IBAction)getCheckCodeAction:(id)sender {
    //判断如果手机号码不合法，可不触发倒计时
    if(0){
        self.getCheckCodeBtn.start = NO;
        return;
    }
    //如果需要过2秒再执行倒计时
    if(0){
        self.getCheckCodeBtn.terminateCountDown = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.getCheckCodeBtn startCountDown];
            NSLog(@"执行获取验证码操作!!");
        });
        return;
    }
    NSLog(@"执行获取验证码操作!!");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //判断如果验证码请求失败，可重置倒计时按钮
        if(0){
            [self.getCheckCodeBtn resume];
        }
        
    });
}
```

### ZXCountDownCore
* 您也可以不依赖UI控件，直接开启一个倒计时任务

```objective-c
ZXCountDownCore *countDownCore = [[ZXCountDownCore alloc]init];
[countDownCore setCountDown:10 mark:@"testCountDown" resBlock:^(long remainSec) {
    //每秒执行一次
    NSLog(@"remainSec--%ld",remainSec);
}];
//开始倒计时
[countDownCore startCountDown];
```
## Other
* 启用或禁用自动存储倒计时进度：
```objective-c
//disableScheduleStore 是否不存储倒计时进度，默认为NO，即默认存储倒计时进度
view.disableScheduleStore = YES;
view.disableScheduleStore = NO;
```
* 通用倒计时控制：
```objective-c
//开始倒计时
[view startCountDown];
///暂停倒计时
[view pauseCountDown];
//重新开始倒计时
[view reStartCountDown];
//结束倒计时
[view stopCountDown];
///关闭倒计时
[view invalidateTimer];
```
* 禁止倒计时停止时恢复到最初的状态（文字、文字颜色、文字背景色），默认为否，若为否，则remainSec == 0时设置的状态将无效
```objective-c
view.disableResumeWhenEnd = YES;
```
* 获取当前倒计时view的状态
```objective-c
ZXCountViewStatus countViewStatus = view.countViewStatus;
//countViewStatus有以下枚举:
//ZXCountViewStatusEnded = 0x00,    // 倒计时View倒计时未开始或已结束
//ZXCountViewStatusPaused = 0x01,    // 倒计时View已暂停
//ZXCountViewStatusRunning = 0x02,    // 倒计时View正在倒计时
```

### 注意
* 若需要实现多个不同的倒计时view共用进度，例如登录获取验证码按钮，注册获取验证码按钮，找回密码获取验证码按钮，只需设置相同mark即可。
* ZXCountDownView中倒计时结束默认会将UI控件设置回最初的状态，例如刚开始倒计时按钮文字为“点击获取验证码”，倒计时结束您需要设置为“重新获取”，则您需要设置btn.disableResumeWhenEnd = YES，禁止自动将空间设置回最初的状态，并且在resTextFormat中判断remainSec == 0时将按钮设置为“重新获取”即可。
* 若倒计时view执行了暂停操作且倒计时view自动储存进度开启，则重新初始化倒计时view时，它将仍然处于暂停状态。

