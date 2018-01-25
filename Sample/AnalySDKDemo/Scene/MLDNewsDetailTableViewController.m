//
//  MLDNewsDetailTableViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDNewsDetailTableViewController.h"
#import "UIViewController+MLDBackItemHandler.h"
#import "MLDNewsDetailTableViewCell.h"

#import <AnalySDK/AnalySDK.h>

static NSString *const newsDetailReuseId = @"newsDetailReuseId";

@interface MLDNewsDetailTableViewController()<MLDBackItemHandlerProtocol>

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *relatedArray;
@property (weak, nonatomic) UIView *header;
@property (assign, nonatomic) NSInteger relatedIndex;

@property (strong, nonatomic) NSDictionary *currentDict;
@property (strong, nonatomic) NSMutableArray *currentRelatedArray;

@end

@implementation MLDNewsDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"今日新闻";
    
    [self.tableView registerClass:[MLDNewsDetailTableViewCell class] forCellReuseIdentifier:newsDetailReuseId];
    self.tableView.rowHeight = 80 * PUBLICSCALE;
    
    [self setupUI];
    
}
/**
 拦截导航栏返回按钮代理方法
 
 @return YES 继续Pop  NO 不再Pop
 */
- (BOOL)navigationShouldPopOnBackButtonClick
{
    [self.navigationController.childViewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[MLDNewsDetailTableViewController class]])
        {
            [self.navigationController popToViewController:obj animated:YES];
            *stop = YES;
        }
    }];
    return NO;
}

// 视图将要消失时关闭所有弹窗
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)setupUI
{
    NSInteger dataIndex = 0;
    NSDictionary *dict = nil;
    
    dataIndex = self.index;
    dict = self.dataArray[dataIndex];
    
    [AnalySDK trackEvent:@"readNews" eventParams:@{@"title":dict[@"title"]}];
    
    [self refreshHeaderWith:dict];
}

/**
 刷新tableViewHeader
 
 @param dict 字典
 */
- (void)refreshHeaderWith:(NSDictionary *)dict
{
    self.currentDict = dict;
    //清除header
    [self.header removeFromSuperview];
    self.header = nil;
    self.tableView.tableHeaderView = nil;
    
    // header
    UIView *header = [[UIView alloc] init];
    self.header = header;
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, 20, SCREEN_WIDTH - 45 * PUBLICSCALE, 0)];
    titleLabel.text = dict[@"title"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel sizeToFit];
    
    [header addSubview:titleLabel];
    
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, CGRectGetMaxY(titleLabel.frame) + 10, 200, 0)];
    sourceLabel.text = dict[@"source"];
    CGFloat b = (0xa4a4a4 & 0xff) / 255.0;
    CGFloat g = (0xa4a4a4 >> 8 & 0xff) / 255.0;
    CGFloat r = (0xa4a4a4 >> 16 & 0xff) / 255.0;
    
    sourceLabel.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    sourceLabel.font = [UIFont systemFontOfSize:12];
    sourceLabel.textAlignment = NSTextAlignmentLeft;
    [sourceLabel sizeToFit];
    
    [header addSubview:sourceLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, CGRectGetMaxY(sourceLabel.frame), SCREEN_WIDTH - 30 * PUBLICSCALE, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    [header addSubview: line];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, CGRectGetMaxY(line.frame) + 15, SCREEN_WIDTH - 30 * PUBLICSCALE, 0)];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.font = [UIFont systemFontOfSize:17];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *dic = @{NSKernAttributeName : @1.5f};
    NSString *contentText = dict[@"content"];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:contentText attributes:dic];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 15.0;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentText.length)];
    contentLabel.attributedText = attrStr;
    [contentLabel sizeToFit];
    
    [header addSubview:contentLabel];
    
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20 + titleLabel.frame.size.height + 15 + sourceLabel.frame.size.height + contentLabel.frame.size.height + 25);
    self.tableView.tableHeaderView = header;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentRelatedArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLDNewsDetailTableViewCell *cell = (MLDNewsDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:newsDetailReuseId forIndexPath:indexPath];
    
    if (indexPath.row < self.currentRelatedArray.count)
    {
        cell.dict = self.currentRelatedArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.currentRelatedArray[indexPath.row];
    self.relatedIndex = [dict[@"index"] integerValue];
    [self refreshHeaderWith:dict];
    
    [AnalySDK trackEvent:@"readNews" eventParams:@{@"title":dict[@"title"]}];

    
    [self.currentRelatedArray removeAllObjects];
    [self.relatedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = obj;
        if ([dict[@"index"] integerValue] != self.relatedIndex)
        {
            [self.currentRelatedArray addObject:obj];
        }
    }];
    [tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    label.text = @"  相关新闻";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - 懒加载

- (NSArray *)dataArray
{
    if (_dataArray == nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NewsList" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _dataArray;
}

- (NSMutableArray *)relatedArray
{
    if (_relatedArray == nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NewsRelated" ofType:@"plist"];
        _relatedArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    return _relatedArray;
}

- (NSMutableArray *)currentRelatedArray
{
    if (_currentRelatedArray == nil)
    {
        _currentRelatedArray = [NSMutableArray arrayWithCapacity:2];
        if ([self.currentDict[@"index"] integerValue] >= 100)
        {
            [self.relatedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = obj;
                if (![dict[@"index"] isEqualToString:self.currentDict[@"index"]])
                {
                    [_currentRelatedArray addObject:obj];
                }
            }];
        }
        else
        {
            [self.relatedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [_currentRelatedArray addObject:obj];
                if (idx == 1)
                {
                    *stop = YES;
                }
            }];
        }
    }
    return _currentRelatedArray;
}

@end
