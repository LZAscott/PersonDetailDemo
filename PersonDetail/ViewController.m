//
//  ViewController.m
//  PersonDetail
//
//  Created by Scott_Mr on 15/10/23.
//  Copyright © 2015年 Scott_Mr. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"

#define headHeight 200           // 头部视图高度
#define headMinHeight 64         // 头像距离头部视图底部高度
#define tabBarHeight 44          // 选项卡高度

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headConstraint;
@property (weak, nonatomic) UILabel *nickLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat height = headHeight + tabBarHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    
    // 导航栏隐藏
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 导航栏底部阴影隐藏
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Scott_Mr";
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    titleLabel.alpha = 0;
    self.nickLabel = titleLabel;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID
                ];
        cell.backgroundColor = [UIColor greenColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取滑动偏移量(向上滑动，偏移量增大，向下滑动，偏移量减小)
    CGFloat offY = scrollView.contentOffset.y;
    CGFloat delat = offY + (headHeight+tabBarHeight);
    NSLog(@"%d:%.f:%.f",headHeight+tabBarHeight,offY,delat);
    
    // 向上滑动，delat增大，高度减小
    CGFloat heigth = headHeight - delat;
    
    
    if (heigth < headMinHeight) {
        heigth = headMinHeight;
    }
    
    _headConstraint.constant = heigth;
    
    CGFloat alpha = delat/(headHeight-headMinHeight);
    
    // 当alpha大于1，导航条半透明，因此做处理，大于1，就直接=0.99
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    self.nickLabel.alpha = alpha;
    
    UIImage *img = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
}

@end
