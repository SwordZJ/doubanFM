//
//  ZJDiscoverController.m
//  doubanFM
//
//  Created by liuzhouji on 15/8/31.
//  Copyright (c) 2015年 ZJ. All rights reserved.
//


#import "ZJDiscoverController.h"
#import "ZJTagBtn.h"
#import "ZJSearchViewController.h"

@interface ZJDiscoverController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet ZJTagBtn *leftBtn;
@property (weak, nonatomic) IBOutlet ZJTagBtn *rightBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *sc;
@property (nonatomic, weak) UITableView *leftTable; // 兆赫列表
@property (nonatomic, weak) UITableView *rightTable; // 歌单列表


/** 当前选中标签*/
@property (nonatomic, weak) ZJTagBtn *currentSelectedBtn;

@end

@implementation ZJDiscoverController

#pragma mark - 初始化操作
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化界面
    [self setupTable];
    
    [self setupScrollView];
    
    // 默认选中兆赫按钮
    [self fmBtnClick:self.leftBtn];
    
    // 发送请求获取数据
}

- (void)setupScrollView{
    self.sc.delegate = self;
    self.sc.contentSize = CGSizeMake(2 * kScreenWidth, 0);
    self.sc.pagingEnabled = YES;
}

static NSString *const ZJFMTableCellID = @"FMCell";
static NSString *const ZJSongListTableCellID = @"songListCell";
- (void)setupTable{
    UITableView *leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.sc.height) style:UITableViewStylePlain];
    leftTable.dataSource = self;
    leftTable.delegate = self;
    self.leftTable = leftTable;
    [self.sc addSubview:leftTable];
    [leftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:ZJFMTableCellID];
    
    UITableView *rightTable = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.sc.height) style:UITableViewStylePlain];
    rightTable.dataSource = self;
    rightTable.delegate = self;
    self.rightTable = rightTable;
    [self.sc addSubview:rightTable];
    [rightTable registerClass:[UITableViewCell class] forCellReuseIdentifier:ZJSongListTableCellID];
    
}

#pragma mark - 事件处理
#pragma mark 兆赫按钮点击事件
- (IBAction)fmBtnClick:(ZJTagBtn *)sender {
    
    self.currentSelectedBtn.selected = NO;
    sender.selected = YES;
    self.currentSelectedBtn = sender;
    
    self.sc.contentOffset = CGPointMake(0, 0);
}
#pragma mark 歌单按钮点击事件
- (IBAction)songListBtnClick:(ZJTagBtn *)sender {
    
    self.currentSelectedBtn.selected = NO;
    sender.selected = YES;
    self.currentSelectedBtn = sender;
    
    self.sc.contentOffset = CGPointMake(kScreenWidth, 0);
}

#pragma mark 搜索按钮点击事件
- (IBAction)searchBtnClick {
    ZJSearchViewController *searchVc = [[ZJSearchViewController alloc] init];
    
    [self presentViewController:searchVc animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTable) {
        return 20;
    }
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        //    1.创建cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJFMTableCellID];
        //    2.设置cell的数据
        cell.textLabel.text = [NSString stringWithFormat:@"leftCell----%zd,%zd",indexPath.section,indexPath.row];
        //    3.返回cell
        return cell;
    }
    //    1.创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJSongListTableCellID];
    //    2.设置cell的数据
    cell.textLabel.text = [NSString stringWithFormat:@"rightCell++++%zd,%zd",indexPath.section,indexPath.row];
    //    3.返回cell
    return cell;
}

#pragma mark - UIScrollViewDelegate
// 监听滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView != self.sc) return;

    // 计算当前页面
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    // 当前索引的按钮选中
    if (index == 0) {
        [self fmBtnClick:self.leftBtn];
    }else{
        [self songListBtnClick:self.rightBtn];
    }
}

@end
