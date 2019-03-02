# ZXCountDownView

## 效果图
![Image text](http://www.zxlee.cn/ZXCountDownViewDemo1.gif) 

***

## Demo

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
//开始倒计时
[self.scheduleStoreLabel startCountDown];
```
* 设置一个点击获取验证码的Button，且自动记录倒计时进度：

```objective-c
//此处实现了一个倒计时20秒，且显示“还剩20、19、18...秒后重试”的Btn，且退出重新进入当前控制器或重启App不受影响。
[self.getCheckCodeBtn enableAutoCountDown:20 mark:@"GetCheckCodeBtn" resTextFormat:^NSString *(long remainSec) {
    return [NSString stringWithFormat:@"%ld秒后重发",remainSec];
}];
```
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
* 启用或禁用自动存储倒计时进度：
```objective-c
//disableScheduleStore 是否不存储倒计时进度，默认为NO，即默认存储倒计时进度
obj.disableScheduleStore = YES;
obj.disableScheduleStore = NO;
```
* 倒计时控制：
```objective-c
//开始倒计时
-(void)startCountDown;
//重新开始倒计时
-(void)reStartCountDown;
//结束倒计时
-(void)stopCountDown;
```
