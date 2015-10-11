//
//  ZJMainViewControlle.m
//  doubanFM
//
//  Created by liuzhouji on 15/8/17.
//  Copyright (c) 2015年 ZJ. All rights reserved.
//

#import "ZJMainViewControlle.h"
#import "ZJLeftView.h"
#import "ZJBaseNavController.h"
#import "ZJLoginViewController.h"
#import "ZJDiscoverController.h"

#define kLeftViewDistanceScale 0.8
#define kLeftViewDistanceTop 64
#define KZJCoverTag 100


typedef enum{
    UIBarButtonItemLeftMenu = 998,
    UIBarButtonItemRightMenu = 999,
    UIBarButtonItemSearch = 1000
    
}ZJNavBarItem;


@interface ZJMainViewControlle ()<ZJLeftViewDelegate>
@property (nonatomic, weak) ZJLeftView *leftView;
@property (nonatomic, weak) ZJBaseNavController *showNavController;
@end

@implementation ZJMainViewControlle

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    


    // 1.添加子控制器
    [self setChildControllers];

    // 2.添加左部菜单视图
    [self setupLeftView];
    
    // 3.添加右部菜单视图
    

}
// 添加子控制器
- (void)setChildControllers{
    // 创建登录导航控制器
    ZJLoginViewController *loginVc = [[ZJLoginViewController alloc] init];
//    loginVc.view.backgroundColor = [UIColor whiteColor];
    [self setUpNav:loginVc title:@"登录"];
    // 创建发现音乐导航控制器
    ZJDiscoverController *discoverVc = [[ZJDiscoverController alloc] init];
//    discoverVc.view.backgroundColor = ZJRandomColor;
    [self setUpNav:discoverVc title:@"发现音乐"];
    // 创建我的离线导航控制器
    UIViewController *downloadVc = [[UIViewController alloc] init];
    downloadVc.view.backgroundColor = ZJRandomColor;
    [self setUpNav:downloadVc title:@"我的离线"];
    // 创建我的收藏导航控制器
    UIViewController *myCollectionVc = [[UIViewController alloc] init];
    myCollectionVc.view.backgroundColor = ZJRandomColor;
    [self setUpNav:myCollectionVc title:@"我的收藏"];
    // 创建手机里的音乐导航控制器
    UIViewController *musicInMyPhoneVc = [[UIViewController alloc] init];
    musicInMyPhoneVc.view.backgroundColor = ZJRandomColor;
    [self setUpNav:musicInMyPhoneVc title:@"手机里的音乐"];
    
}

// 添加左部菜单视图
-(void)setupLeftView{
    // 创建菜单视图
    ZJLeftView *leftView = [[ZJLeftView alloc] init];
    CGFloat leftViewW = kScreenWidth * kLeftViewDistanceScale;
    CGFloat leftViewX = -leftViewW;
    CGFloat leftViewY = kLeftViewDistanceTop;
    CGFloat leftViewH = kScreenHeight - kLeftViewDistanceTop;
    leftView.backgroundColor = [UIColor whiteColor];
    leftView.frame = CGRectMake(leftViewX, leftViewY, leftViewW, leftViewH);
    self.leftView = leftView;
    [self.view addSubview:leftView];
    // 设置代理，显示第一个视图
    leftView.delegate = self;
//    // 添加拖拽事件
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//    [leftView addGestureRecognizer:pan];
}

#warning 手势部分未完成，待完善
#pragma mark - 拖拽手势方法
//-(void)pan:(UIPanGestureRecognizer *)pan{
//    // 获取当前偏移量
//    CGFloat offsetX = [pan translationInView:self.leftView].x;
//    // 计算当前的X值
//    CGFloat curX = self.leftView.x + offsetX;
//    self.leftView.transform = CGAffineTransformTranslate(self.leftView.transform, offsetX, 0);
//    // 复位
//    [pan setTranslation:CGPointZero inView:self.leftView];
//
//    // 根据偏移值偏移
//    if (curX > 0) {
//        curX = 0;
//    }else if(curX < -self.leftView.width)  {
//        curX = -self.leftView.width;
//    }
//    if (pan.state == UIGestureRecognizerStateEnded) {
//        if (curX > -self.leftView.width * 0.5) {
//            curX = 0;
//        }else if (curX < -self.leftView.width * 0.5)
//        {
//            curX = -self.leftView.width;
//        }
//    }
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.leftView.x = curX;
//    }];
//    NSLog(@"%@",NSStringFromCGRect(self.leftView.frame));
//}



/**
 *  根据传入的根控制器创建导航控制器
 *
 *  @param vc    根控制器
 *  @param title 导航条标题
 */
-(void)setUpNav:(UIViewController *)vc title:(NSString *)title{
    // 设置导航条内容
    vc.navigationItem.title = title;
    // 创建左边按钮
    vc.navigationItem.leftBarButtonItem =  [UIBarButtonItem itemWithImageName:@"top_navigation_menuicon" title:nil target:self action:@selector(LeftMenuClick)];
    
    // 创建右边按钮
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithImageName:@"searchm" title:nil target:self action:@selector(searchBtnClick)];
    UIBarButtonItem *rightMenuItem  = [UIBarButtonItem itemWithImageName:@"setting" title:nil target:self action:@selector(rightMenuBtnClick)];
    vc.navigationItem.rightBarButtonItems = @[rightMenuItem,searchItem];
    
    // 创建导航控制器
    ZJBaseNavController *discoverNav = [[ZJBaseNavController alloc] initWithRootViewController:vc];
    [self addChildViewController:discoverNav];
}


#pragma mark - 导航栏Item点击事件
-(void)LeftMenuClick{
    
    // 创建蒙板视图
    UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
    cover.frame = self.showNavController.view.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.tag = KZJCoverTag;
    cover.alpha = 0.1;
    [self.showNavController.view addSubview:cover];
    [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
    // 移动左部菜单，并且菜单在最外部显示
    [UIView animateWithDuration:0.5 animations:^{
        self.leftView.transform = CGAffineTransformMakeTranslation(self.leftView.width, 0);
        cover.alpha = 0.2;
    }];
//    ZJLog(@"%@",NSStringFromCGRect(_leftView.frame));
}

// 蒙板点击事件
-(void)coverClick:(UIView *)cover{
    // 左边视图形变恢复
    [UIView animateWithDuration:0.5 animations:^{
        self.leftView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 移除蒙板
        [cover removeFromSuperview];
    }];
}

-(void)searchBtnClick{
    NSLog(@"%s",__func__);

}
-(void)rightMenuBtnClick{
    NSLog(@"%s",__func__);
}


#pragma mark - ZJLeftViewDelegate
-(void)leftViewDidSelected:(ZJLeftView *)leftView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    // 1.移除上一个显示的导航控制器的View
    ZJBaseNavController *oldNav = self.childViewControllers[fromIndex];
    [oldNav.view removeFromSuperview];
    // 2.显示当前的导航控制器的View
    ZJBaseNavController *newNav = self.childViewControllers[toIndex];
    [self.view insertSubview:newNav.view belowSubview:self.leftView];
    // 3.记录当前显示的导航控制器
    self.showNavController = newNav;
    // 4.移除蒙板和左边视图形变(即调用蒙板点击事件即可)
    [UIView animateWithDuration:0.5 animations:^{
        [self coverClick:[newNav.view viewWithTag:KZJCoverTag]];
    }];
}

@end
