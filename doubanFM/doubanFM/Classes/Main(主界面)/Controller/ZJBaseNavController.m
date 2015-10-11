//
//  ZJBaseNavController.m
//  doubanFM
//
//  Created by liuzhouji on 15/8/17.
//  Copyright (c) 2015年 ZJ. All rights reserved.
//

#import "ZJBaseNavController.h"

@interface ZJBaseNavController ()

@end

@implementation ZJBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
+(void)initialize{
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 设置导航条背景
    [appearance setBackgroundImage:[UIImage imageWithColor:ZJColor(91, 179, 102)] forBarMetrics:UIBarMetricsDefault];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
