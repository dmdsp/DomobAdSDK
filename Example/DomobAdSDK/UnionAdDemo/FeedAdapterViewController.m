//
//  FeedAdapterViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/5/22.
//

#import "FeedAdapterViewController.h"
#import "UIView+Toast.h"
#import <DomobSDKAdapter/DomobFeedManager.h>

static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface FeedAdapterViewController ()<UITableViewDelegate,UITableViewDataSource,DomobFeedManagerDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) DomobFeedAdapter * feedAd;

@end

@implementation FeedAdapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"模版渲染",@"隐藏弹出视图"];
    [self.view addSubview:self.listTable];
    
}
#pragma mark - 设置tableview
- (UITableView *)listTable{
    if (!_listTable) {
        _listTable = [[UITableView alloc]initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width-40,40*_titleArr.count) style:UITableViewStylePlain];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
        _listTable.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _listTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_listTable registerClass:[UITableViewCell class] forCellReuseIdentifier:cellWithIdentifier];
        
        
    }
    return _listTable;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellWithIdentifier];
    cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        kWeakSelf(self);
        [[DomobFeedManager new] loadFeedAdTemplateAdWithSlotID:@"118171711352246" popupViewHidden:NO completion:^(DomobFeedAdapter * _Nonnull feedAdapter) {
            weakself.feedAd = feedAdapter;
            weakself.feedAd.delegate = weakself;
        }];
    }else{
        [[DomobFeedManager new] loadFeedAdTemplateAdWithSlotID:@"118171711352246" popupViewHidden:YES completion:^(DomobFeedAdapter * _Nonnull feedAdapter) {
            self.feedAd = feedAdapter;
            self.feedAd.delegate = self;
        }];    }
}
#pragma  ---DMFeedAdDelegate
- (void)feedAdDidClick:(nonnull DomobFeedAdapter *)feedAd {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd被点击--"]
                duration:3.0
                position:CSToastPositionCenter];
}
- (void)feedAdDidFailToLoadWithError:(nonnull NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd加载失败"]
                duration:3.0
                position:CSToastPositionCenter];
    [_feedAd biddingFeedSuccess:self.feedAd.ecpm-1];
    [_feedAd biddingFeedFailed:self.feedAd.ecpm-1 Code:DMAdBiddingCodeNoValidSpec];
}

- (void)feedAdDidFailToRenderWithError:(nonnull NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd渲染失败--"]
                duration:3.0
                position:CSToastPositionCenter];
}

- (void)feedAdDidLoad:(nonnull DomobFeedAdapter *)feedAd {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd加载成功--"]
                duration:3.0
                position:CSToastPositionCenter];
    
}

- (void)feedAdDidRender:(nonnull DomobFeedAdapter *)feedAd {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd渲染成功--"]
                duration:3.0
                position:CSToastPositionCenter];
    //渲染成功后已经将view返回
    //可以将view展示在当前的视图上
    self.feedAd = feedAd;
    self.feedAd.feedView.frame = CGRectMake(0, 200, self.feedAd.feedView.bounds.size.width, self.feedAd.feedView.bounds.size.height);
    [self.view addSubview:self.feedAd.feedView];
}

- (void)feedAdDidShow:(nonnull DomobFeedAdapter *)feedAd {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd已经开始展示"]
                duration:3.0
                position:CSToastPositionCenter];
}
/// 广告被关闭
- (void)feedAdDidClose:(DomobFeedAdapter *)feedAd{
    [self.view makeToast:[NSString stringWithFormat:@"feedAd被关闭了"]
                duration:3.0
                position:CSToastPositionCenter];
}

@end
