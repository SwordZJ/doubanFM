//
//  ZJLeftView.h
//  doubanFM
//
//  Created by liuzhouji on 15/8/17.
//  Copyright (c) 2015年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJLeftView;
@protocol ZJLeftViewDelegate <NSObject>
@optional
-(void)leftViewDidSelected:(ZJLeftView *)leftView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end

@interface ZJLeftView : UIView

@property (nonatomic, weak) id<ZJLeftViewDelegate> delegate;
@end
