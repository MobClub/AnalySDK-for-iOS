//
//  MLDVideoDetailTableViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDVideoDetailTableViewController.h"
#import "UIViewController+MLDBackItemHandler.h"
#import "MLDVideoDetailTableViewCell.h"
#import <AnalySDK/AnalySDK.h>

static NSString *const videoDetailReuseId = @"videoDetailReuseId";

@interface MLDVideoDetailTableViewController()<MLDBackItemHandlerProtocol, UIWebViewDelegate>

@property (weak, nonatomic) UIWebView *webView;
@property (weak, nonatomic) UIActivityIndicatorView *indicator;
@property (weak, nonatomic) UIView *coverView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *relatedArray;
@property (strong, nonatomic) UILabel *sectionHeader;
@property (copy, nonatomic) NSString *urlString;
@property (assign, nonatomic) NSInteger relatedIndex;
@property (strong, nonatomic) NSDictionary *currentDict;
@property (strong, nonatomic) NSMutableArray *currentRelatedArray;

@end

@implementation MLDVideoDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSInteger dataIndex = 0;
    NSDictionary *dict = nil;
    
    dataIndex = self.index;
    dict = self.dataArray[dataIndex];
    
    self.currentDict = dict;
    self.title = dict[@"title"];
    self.urlString = dict[@"url"];
    [AnalySDK trackEvent:@"watchVideo" eventParams:@{@"videoTitle":self.title,
                                                     @"videoUrl":self.urlString}];
    
    [self.tableView registerClass:[MLDVideoDetailTableViewCell class] forCellReuseIdentifier:videoDetailReuseId];
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
        if (![obj isKindOfClass:[MLDVideoDetailTableViewController class]])
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
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9.0 / 16.0)];
    self.webView = webView;
    webView.delegate = self;
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [webView loadRequest:req];
    
    UIView *coverView = [[UIView alloc] initWithFrame:webView.bounds];
    self.coverView = coverView;
    coverView.backgroundColor = [UIColor blackColor];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.indicator = indicator;
    indicator.hidesWhenStopped = YES;
    indicator.bounds = CGRectMake(0, 0, 50, 50);
    indicator.center = CGPointMake(coverView.bounds.size.width / 2.0, coverView.bounds.size.height / 2.0);
    [indicator startAnimating];
    
    [coverView addSubview:indicator];
    
    [webView addSubview:coverView];
    
    self.tableView.tableHeaderView = webView;
}

- (void)refreshHeaderWith:(NSString *)urlString
{
    [self.indicator startAnimating];
    self.coverView.hidden = NO;
    [self.webView stopLoading];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:req];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicator stopAnimating];
    self.coverView.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentRelatedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLDVideoDetailTableViewCell *cell = (MLDVideoDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:videoDetailReuseId forIndexPath:indexPath];
    
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
    self.currentDict = dict;
    self.relatedIndex = [dict[@"index"] integerValue];
    self.title = dict[@"title"];
    [self refreshHeaderWith:dict[@"url"]];
    
    [AnalySDK trackEvent:@"watchVideo" eventParams:@{@"videoTitle":self.title,
                                                     @"videoUrl":dict[@"url"]}];

    
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
    UILabel *sectionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.sectionHeader = sectionHeader;
    sectionHeader.text = @"  专题联播";
    sectionHeader.font = [UIFont systemFontOfSize:14];
    sectionHeader.textColor = [UIColor blackColor];
    sectionHeader.textAlignment = NSTextAlignmentLeft;
    
    return sectionHeader;
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
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Videos" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArray;
}

- (NSMutableArray *)relatedArray
{
    if (_relatedArray == nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"VideosRelated" ofType:@"plist"];
        _relatedArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    return _relatedArray;
}

- (NSMutableArray *)currentRelatedArray
{
    if (_currentRelatedArray == nil)
    {
        _currentRelatedArray = [NSMutableArray arrayWithCapacity:3];
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
                if (idx == 2)
                {
                    *stop = YES;
                }
            }];
        }
    }
    return _currentRelatedArray;
}

@end
