//
//  FeedAdViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/3/27.
//
//包名：com.sdk.DMAdSDK
//广告位ID：
//118171711352246    ios-信息流
//118171711352274    ios-开屏
//118171711352293    ios-插屏
//118171711352334    ios-banner
//118171711352643    ios-激励视频--横版
//118171711352679    ios-激励视频--竖版  @刘士林 ios-sdk预发布和线上环境的广告配置了
#import "FeedAdViewController.h"
#import "UIView+Toast.h"

#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DM_FeedAd.h>
#import <DMAdSDK/DM_FeedView.h>
static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface FeedAdViewController ()<UITableViewDelegate,UITableViewDataSource,DMFeedAdDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) DM_FeedAd * feedAd;

@property (nonatomic, assign) int showCount;
@property (nonatomic, assign) int clickCount;


@end

@implementation FeedAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showCount = 0;
    _clickCount = 0;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"上图下文",@"上文下图",@"左图右文",@"左文右图",@"自渲染信息流",@"隐藏弹出视图",@"隐藏弹出视图",@"隐藏弹出视图"];
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
    if (indexPath.row == 6) {
        cell.textLabel.text = [NSString stringWithFormat:@"曝光-%d-次",_showCount];
    }else if (indexPath.row == 7){
        cell.textLabel.text = [NSString stringWithFormat:@"点击-%d-次",_clickCount];
    }else{
        cell.textLabel.text = self.titleArr[indexPath.row];
    }
    return cell ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        self.feedAd = [[DM_FeedAd new] loadFeedAdTemplateAdWithSlotID:@"118171711352246" popupViewHidden:NO delegate:self];
        self.feedAd.presentAdViewController = self;
    }else if (indexPath.row==1) {
        self.feedAd = [[DM_FeedAd new] loadFeedAdTemplateAdWithSlotID:@"118171711352246" popupViewHidden:NO delegate:self];

    }else if (indexPath.row==2){
        self.feedAd = [[DM_FeedAd new] loadFeedAdTemplateAdWithSlotID:@"118171711352246" popupViewHidden:NO delegate:self];

    }else if (indexPath.row==3){
        self.feedAd = [[DM_FeedAd new] loadFeedAdTemplateAdWithSlotID:@"118171711352246" popupViewHidden:NO delegate:self];

    }else{
        self.feedAd = [[DM_FeedAd new] loadFeedAdTemplateAdWithSlotID:@"118171711352246" popupViewHidden:YES delegate:self];
    }
}
#pragma  ---DMFeedAdDelegate
- (void)feedAdDidClick:(nonnull DM_FeedAd *)feedAd {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd被点击--%@",_feedAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    _clickCount++;
    [self.listTable reloadData];
}
- (void)feedAdDidFailToLoadWithError:(nonnull NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd加载失败--%@",_feedAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    [_feedAd biddingFeedSuccess:self.feedAd.bidPrice-1];
    [_feedAd biddingFeedFailed:self.feedAd.bidPrice-1 Code:DMAdBiddingCodeNoValidSpec];
}

- (void)feedAdDidFailToRenderWithError:(nonnull NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd渲染失败--%@",_feedAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}

- (void)feedAdDidLoad:(nonnull DM_FeedAd *)feedAd {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd加载成功--%@",_feedAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}

- (void)feedAdDidRender:(nonnull DM_FeedAd *)feedAd {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd渲染成功--%@",_feedAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    //渲染成功后已经将view返回
    //可以将view展示在当前的视图上
    self.feedAd = feedAd;
    self.feedAd.feedView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, self.feedAd.feedView.bounds.size.width, self.feedAd.feedView.bounds.size.height);
    [self.feedAd.feedView turnOffShake];
    [self.view addSubview:self.feedAd.feedView];
}

- (void)feedAdDidShow:(nonnull DM_FeedAd *)feedAd {
    [self.view makeToast:[NSString stringWithFormat:@"feedAd已经开始展示--%@",_feedAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    _showCount++;
    [self.listTable reloadData];
}
/// 广告被关闭
- (void)feedAdDidClose:(DM_FeedAd *)feedAd{
    [self.view makeToast:[NSString stringWithFormat:@"feedAd被关闭了--%@",_feedAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}
/// 广告详情页关闭回调
- (void)feedAdDetailViewDidClose:(DM_FeedAd *)feedAd{
    NSLog(@"feedAd广告详情页已经关闭");
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view makeToast:[NSString stringWithFormat:@"feedAd广告详情页已经关闭--%@",feedAd.materialId]
                                     duration:3.0
                position:CSToastPositionCenter];
}
/// 广告详情页将展示回调
- (void)feedAdDetailViewDidPresentScreen:(DM_FeedAd *)feedAd{
    NSLog(@"feedAd广告详情页已经打开");
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view makeToast:[NSString stringWithFormat:@"feedAd广告详情页已经打开--%@",feedAd.materialId]
                                     duration:3.0
                position:CSToastPositionCenter];
}
@end
