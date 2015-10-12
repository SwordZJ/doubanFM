//
//  ZJSearchViewController.m
//  doubanFM
//
//  Created by liuzhouji on 15/10/12.
//  Copyright © 2015年 ZJ. All rights reserved.
//

#import "ZJSearchViewController.h"
#import "ZJTagBtn.h"
@interface ZJSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ZJTagBtn *FMTagBtn;
@property (weak, nonatomic) IBOutlet ZJTagBtn *songListTagBtn;

/** 当前选中标签*/
@property (nonatomic, weak) ZJTagBtn *currentSelectedBtn;

@end

@implementation ZJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认选中兆赫
    [self FMBtnClick:self.FMTagBtn];
}



#pragma mark - 事件处理
/**
 *  取消按钮
 */
- (IBAction)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  按兆赫显示搜索结果
 */
- (IBAction)FMBtnClick:(ZJTagBtn *)sender {
    [self switchSelectedBtn:sender];
}

/**
 *  按歌单显示搜索结果
 */
- (IBAction)songListBtnClick:(ZJTagBtn *)sender {
    [self switchSelectedBtn:sender];
}
- (void)switchSelectedBtn:(ZJTagBtn *)tagBtn{
    self.currentSelectedBtn.selected = NO;
    tagBtn.selected = YES;
    self.currentSelectedBtn = tagBtn;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    1.创建cell
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //    2.设置cell的数据
    cell.textLabel.text = @"搜索结果";
    //    3.返回cell
    return cell;
}
@end
