//
//  ToponSplashViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/9/5.
//

#import "ToponSplashViewController.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkSplash/AnyThinkSplash.h>
#import "ToponInterstitialViewController.h"
#import "ToponBannerViewController.h"
#import <DMAdSDK/DMAds.h>
#import "ToponRewardVideoAdViewController.h"
#import "ToponFeedViewController.h"

#import "UIView+Toast.h"
static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface ToponSplashViewController ()<UITableViewDelegate,UITableViewDataSource,ATSplashDelegate,ATAdLoadingDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, assign) bool isFull;
@property (nonatomic, strong) UIImageView * bottomView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) int showCount;
@property (nonatomic, assign) int clickCount;
@end

@implementation ToponSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [ATAPI setLogEnabled:YES];//Turn on debug logs
    [[ATAPI sharedInstance] startWithAppID:@"a66d95b9ba02f8" appKey:@"a5854aba031dc4e299c0c0839df189e9d" error:nil];

    // 设置测试竞价的idfa，例如Meta广告测试设备等
//    [ATAPI setHeaderBiddingTestModeWithDeviceID:@"B08392CD-0E68-4682-BA30-39AB7A42F831"];

    self.titleArr= @[@"开屏广告",@"模版渲染插屏广告",@"模版渲染Banner广告",@"模版渲染激励视频广告",@"信息流广告"];
    [self.view addSubview:self.listTable];
    [self.view addSubview:self.textView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - 设置tableview
- (UITableView *)listTable{
    if (!_listTable) {
        _listTable = [[UITableView alloc]initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width-40,40*_titleArr.count) style:UITableViewStylePlain];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.backgroundColor = [UIColor whiteColor];
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
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.listTable.frame), self.view.bounds.size.width-40, 150)];
        _textView.backgroundColor = [UIColor lightGrayColor];
        _textView.editable = YES; // 禁止编辑
        _textView.text = [[DMAds shareInstance] getSdkDevice];
        // 根据内容调整UITextView的高度
//        [_textView sizeToFit];
    }
    return _textView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellWithIdentifier];
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
        _isFull = NO;
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
        // 设置开屏广告中支持广告源设置加载超时时间，并不是整个广告位请求的时间
        [mutableDict setValue:@5.5 forKey:kATSplashExtraTolerateTimeoutKey];
        [[ATAdManager sharedManager] loadADWithPlacementID:@"b66d95c193e52c"
                                                     extra:mutableDict
                                                  delegate:self
                                             containerView:_bottomView];
    }else if (indexPath.row==1) {
        ToponInterstitialViewController * interstitial = [[ToponInterstitialViewController alloc]init];
        [self.navigationController pushViewController:interstitial animated:YES];
    }else if (indexPath.row==2){
        ToponBannerViewController * banner = [[ToponBannerViewController alloc]init];
        [self.navigationController pushViewController:banner animated:YES];
    }else if (indexPath.row==3){
        ToponRewardVideoAdViewController * rewardVideo = [[ToponRewardVideoAdViewController alloc]init];
        [self.navigationController pushViewController:rewardVideo animated:YES];

    }else{
        ToponFeedViewController * feed = [[ToponFeedViewController alloc]init];
        [self.navigationController pushViewController:feed animated:YES];
    }
}
#pragma mark - ATSplashDelegate
- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    NSLog(@"广告源--AD--开始--ATSplashViewController::didStartLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    NSLog(@"广告源--AD--完成--ATSplashViewController::didFinishLoadingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    NSLog(@"广告源--AD--失败--ATSplashViewController::didFailToLoadADSourceWithPlacementID:%@---error:%@---extra:%@", placementID,error,extra);
}

// bidding
- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    NSLog(@"广告源--bid--开始--ATSplashViewController::didStartBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra{
    NSLog(@"广告源--bid--完成--ATSplashViewController::didFinishBiddingADSourceWithPlacementID:%@---extra:%@", placementID,extra);
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error{
    NSLog(@"广告源--bid--失败--ATSplashViewController::didFailBiddingADSourceWithPlacementID:%@--error:%@---extra:%@", placementID,error,extra);
}

- (void)didFinishLoadingSplashADWithPlacementID:(NSString *)placementID isTimeout:(BOOL)isTimeout {
    NSLog(@"开屏成功:%@----是否超时:%d",placementID,isTimeout);
    NSLog(@"开屏didFinishLoadingSplashADWithPlacementID:");
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

    // 展示前需判断广告是否填充
    if ([[ATAdManager sharedManager] splashReadyForPlacementID:placementID]) {
        // 广告已填充，展示广告
        [[ATAdManager sharedManager] showSplashWithPlacementID:placementID scene: @"f5e549727efc49" window:[self getKeyWindowMethodOne] inViewController:self extra:mutableDict delegate:self];
    }
}

- (void)didTimeoutLoadingSplashADWithPlacementID:(NSString *)placementID {
    NSLog(@"开屏超时:%@",placementID);
    NSLog(@"开屏didTimeoutLoadingSplashADWithPlacementID:");
}

- (void)didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"开屏ATSplashViewController:: didFailToLoadADWithPlacementID");
}

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"开屏ATSplashViewController:: didFinishLoadingADWithPlacementID");
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

    // 展示前需判断广告是否填充
    if ([[ATAdManager sharedManager] splashReadyForPlacementID:placementID]) {
        // 广告已填充，展示广告
        [[ATAdManager sharedManager] showSplashWithPlacementID:placementID scene: @"f5e549727efc49" window:[self getKeyWindowMethodOne] inViewController:self extra:mutableDict delegate:self];
    }
}

- (void)splashDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"开屏ATSplashViewController:: splashDeepLinkOrJumpForPlacementID:placementID:%@", placementID);
}

- (void)splashDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"开屏ATSplashViewController::splashDidClickForPlacementID:%@",placementID);
}

- (void)splashDidCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"开屏ATSplashViewController::splashDidCloseForPlacementID:%@ extra:%@",placementID,extra);
}

- (void)splashDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"开屏ATSplashViewController::splashDidShowForPlacementID:%@",placementID);
}

-(void)splashZoomOutViewDidClickForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra {
    NSLog(@"开屏ATSplashViewController::splashZoomOutViewDidClickForPlacementID:%@",placementID);
}

-(void)splashZoomOutViewDidCloseForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra {
    NSLog(@"开屏ATSplashViewController::splashZoomOutViewDidCloseForPlacementID:%@",placementID);
}

- (void)splashDetailDidClosedForPlacementID:(NSString*)placementID extra:(NSDictionary *) extra {
    NSLog(@"ATSplashViewController::splashDetailDidClosedForPlacementID:%@",placementID);
}

- (void)splashDidShowFailedForPlacementID:(NSString*)placementID error:(NSError *)error extra:(NSDictionary *) extra {
    NSLog(@"开屏ATSplashViewController::splashDidShowFailedForPlacementID:%@",placementID);
}

- (void)splashCountdownTime:(NSInteger)countdown forPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"开屏ATSplashViewController::splashCountdownTime:%ld forPlacementID:%@",countdown,placementID);
    
//    // 自定义倒计时回调，需要自行处理按钮文本显示
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSString *title = [NSString stringWithFormat:@"%lds | Skip",countdown/1000];
//        if (countdown/1000) {
//            [self.skipButton setTitle:title forState:UIControlStateNormal];
//        }
//    });
}

- (UIWindow *)getKeyWindowMethodOne {
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                for (UIWindow *window in windowScene.windows)
                {
                    if (window.isKeyWindow)
                    {
                        return window;
                    }
                }
            }
        }
    } else {
        // 添加到当前window上，并置顶到最上层
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
        if (window) {
            return window;
        }
        return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}
@end
