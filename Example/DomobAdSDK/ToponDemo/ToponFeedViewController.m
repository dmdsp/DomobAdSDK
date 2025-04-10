//
//  ToponFeedViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/9/10.
//

#import "ToponFeedViewController.h"

#import "UIView+Toast.h"

#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkNative/AnyThinkNative.h>

static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface ToponFeedViewController ()<UITableViewDelegate,UITableViewDataSource,ATNativeADDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;

@property (nonatomic, assign) int showCount;
@property (nonatomic, assign) int clickCount;


@end

@implementation ToponFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showCount = 0;
    _clickCount = 0;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"自渲染信息流"];
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
    NSDictionary *dict = @{};
      [[ATAdManager sharedManager] loadADWithPlacementID:@"b66dfe4db4aee5" extra:dict delegate:self];
}
#pragma  ---DMFeedAdDelegate
/// Callback when the successful loading of the ad
/// 广告位加载成功
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID{
    // 展示前判断广告是否准备好
    if ([[ATAdManager sharedManager] nativeAdReadyForPlacementID:placementID]) {
        // 获取广告offer对象
        ATNativeAdOffer *offer = [[ATAdManager sharedManager] getNativeAdOfferWithPlacementID:placementID];

        // 初始化config配置
        ATNativeADConfiguration *config = [[ATNativeADConfiguration alloc] init];
        config.ADFrame = CGRectMake(0, 100, self.view.bounds.size.width, 300);
        config.delegate = self;
        config.rootViewController = self;

        // 创建nativeADView
        ATNativeADView *nativeADView = [[ATNativeADView alloc] initWithConfiguration:config currentOffer:offer placementID:placementID];
        if (!offer.nativeAd.isExpressAd) {
            NSLog(@"🔥--原生自渲染");
            
        }else {
            //模版广告
            NSLog(@"🔥--原生模板");
            NSLog(@"🔥--三方SDK返回原生模板广告宽高：%lf，%lf",offer.nativeAd.nativeExpressAdViewWidth,offer.nativeAd.nativeExpressAdViewHeight);
        }
        
        // 渲染广告
        [offer rendererWithConfiguration:config selfRenderView:nil nativeADView:nativeADView];
        [self.view addSubview:nativeADView];
    }
}

/// Callback of ad loading failure
/// 广告位加载失败
- (void)didFailToLoadADWithPlacementID:(NSString*)placementID
                                 error:(NSError*)error{
    
}
                                 
/// Native ads displayed successfully
/// 原生广告位展示成功
- (void)didShowNativeAdInAdView:(ATNativeADView *)adView
                    placementID:(NSString *)placementID
                          extra:(NSDictionary *)extra{
    
}

/// Native ad click
/// 原生广告位被点击
- (void)didClickNativeAdInAdView:(ATNativeADView *)adView
                     placementID:(NSString *)placementID
                           extra:(NSDictionary *)extra{
    
}
@end
