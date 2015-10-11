//
//  UIBarButtonItem+Extension.h
//  doubanFM
//
//  Created by liuzhouji on 15/8/17.
//  Copyright (c) 2015年 ZJ. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    if (title) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
    }
    else if (!title) { // 设置按钮的尺寸为背景图片的尺寸
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        button.size = button.currentBackgroundImage.size;
    }
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    return returnItem;
}




@end
