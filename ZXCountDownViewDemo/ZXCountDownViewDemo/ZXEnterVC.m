//
//  ZXEnterVC.m
//  ZXCountDownViewDemo
//
//  Created by 李兆祥 on 2019/2/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCountDownView

#import "ZXEnterVC.h"
#import "ZXMainVC.h"
@interface ZXEnterVC ()

@end

@implementation ZXEnterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZXMainVC *VC = [[ZXMainVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
