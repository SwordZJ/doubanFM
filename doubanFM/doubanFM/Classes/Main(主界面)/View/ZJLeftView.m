//
//  ZJLeftView.m
//  doubanFM
//
//  Created by liuzhouji on 15/8/17.
//  Copyright (c) 2015年 ZJ. All rights reserved.
//

#import "ZJLeftView.h"
#import "ZJButton.h"

@interface ZJLeftView ()
// 记录当前选中按钮
@property (nonatomic, weak) UIButton *selectedBtn;
@end


@implementation ZJLeftView


-(void)awakeFromNib{
    // 初始化
    [self setup];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self setup];
    }
    return self;
}

// 初始化操作
-(void)setup{
    // 创建按钮
    // 根据传入的图片和title创建按钮
    CGFloat alpha = 0.2;
    [self addBtnWithIcon:@"user" title:@"未登录" selectedColor:ZJColorRGBA(202, 68, 73, alpha)];
    [self addBtnWithIcon:@"sidebar_nav_discover" title:@"发现音乐" selectedColor:ZJColorRGBA(190, 111, 69, alpha)];
    [self addBtnWithIcon:@"sidebar_nav_downLoad" title:@"我的离线" selectedColor:ZJColorRGBA(76, 132, 190, alpha)];
    [self addBtnWithIcon:@"sidebar_nav_collection" title:@"我的收藏" selectedColor:ZJColorRGBA(101, 170, 78, alpha)];
    [self addBtnWithIcon:@"sidebar_nav_music" title:@"手机中的音乐" selectedColor:ZJColorRGBA(170, 172, 73, alpha)];
    [self addBtnWithIcon:@"sidebar_nav_collection" title:@"设置" selectedColor:ZJColorRGBA(170, 172, 73, alpha)];

}





/**
 *  根据传入的图片和title创建按钮对象
 *
 *  @param icon 图片名称
 *  @param title    标题
 *  @param selectedColor 选中背景颜色
 */
-(void)addBtnWithIcon:(NSString *)icon title:(NSString *)title selectedColor:(UIColor *)color{
    
    ZJButton *btn = [ZJButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    
    btn.tag = self.subviews.count - 1;
    
    // 监听按钮点击事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    // 设置按钮文字和图片
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 设置选中和文字颜色
    [btn setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateSelected];
    [btn setTitleColor:ZJColor(91, 179, 102) forState:UIControlStateSelected];
    // 设置高亮时图标不变色
    btn.adjustsImageWhenHighlighted = NO;
    
    // 调整btn的位置
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}


// 重写代理的setter方法
-(void)setDelegate:(id<ZJLeftViewDelegate>)delegate{
    _delegate = delegate;
    
    // 默认选中第一行
    [self btnClick:self.subviews[1]];
}

// 按钮点击事件
-(void)btnClick:(UIButton *)btn{
    
    // 通知代理
    if ([_delegate respondsToSelector:@selector(leftViewDidSelected:fromIndex:toIndex:)]) {
        [_delegate leftViewDidSelected:self fromIndex:self.selectedBtn.tag toIndex:btn.tag];
    }
    
    // 当前按钮选中并记录，上一个按钮取消选中
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

// 布局子控件
// 布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    // 遍历子控件
    NSInteger subViewsCount = self.subviews.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.width;
    CGFloat btnH = self.height * 0.7 / subViewsCount;
    for (int i = 0; i < subViewsCount; i++) {
        UIButton *btn = self.subviews[i];
        btnY = i * btnH;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}



@end
