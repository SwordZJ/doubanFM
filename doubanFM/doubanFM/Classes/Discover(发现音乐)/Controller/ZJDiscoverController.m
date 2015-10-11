//
//  ZJDiscoverController.m
//  doubanFM
//
//  Created by liuzhouji on 15/8/31.
//  Copyright (c) 2015年 ZJ. All rights reserved.
//

#import "ZJDiscoverController.h"

@interface ZJDiscoverController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *sc;
@property (nonatomic, weak) UITableView *leftTable; // 兆赫列表
@property (nonatomic, weak) UITableView *rightTable; // 歌单列表
@end

@implementation ZJDiscoverController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // 初始化界面
    UITableView *leftTable = [[UITableView alloc] initWithFrame:self.sc.bounds style:UITableViewStylePlain];
    leftTable.dataSource = self;
    leftTable.delegate = self;
    self.leftTable = leftTable;
    [self.sc addSubview:leftTable];
    UITableView *rightTable = [[UITableView alloc] initWithFrame:self.sc.bounds style:UITableViewStylePlain];
    rightTable.x = kScreenWidth;
    leftTable.dataSource = self;
    leftTable.delegate = self;
    self.rightTable = rightTable;
    [self.sc addSubview:rightTable];
    self.sc.contentSize = CGSizeMake(2 * kScreenWidth, 0);
    self.sc.pagingEnabled = YES;
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    1.创建cell
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //    2.设置cell的数据
    cell.textLabel.text = [NSString stringWithFormat:@"%zd,%zd",indexPath.section,indexPath.row];
    //    3.返回cell
    return cell;
}



#pragma mark - 按钮点击事件
- (IBAction)leftBtnClick:(id)sender {
    
}
- (IBAction)rightBtnClick:(id)sender {
    
}




@end
