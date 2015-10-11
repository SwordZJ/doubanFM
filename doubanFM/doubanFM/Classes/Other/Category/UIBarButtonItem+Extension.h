//
//  UIBarButtonItem+Extension.h
//  doubanFM
//
//  Created by liuzhouji on 15/8/17.
//  Copyright (c) 2015年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action;
@end
