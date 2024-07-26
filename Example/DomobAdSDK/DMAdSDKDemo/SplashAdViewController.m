//
//  ViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/3/14.
//

#import "SplashAdViewController.h"
#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DM_SplashAd.h>
#import "FeedAdViewController.h"
#import "BannerAdViewController.h"
#import "InterstitialAdViewController.h"
#import "RewardVideoAdViewController.h"

#import "UIView+Toast.h"
static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface SplashAdViewController ()<UITableViewDelegate,UITableViewDataSource,DMSplashAdDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, assign) bool isFull;
@property (nonatomic, strong) DM_SplashAd * splashAd;
@property (nonatomic, strong) UIImageView * bottomView;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation SplashAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[DMAds shareInstance] setLocationDisable];
//    [[DMAds shareInstance] setDebugMode:YES];
    [[DMAds shareInstance] initSDK];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleArr= @[[[DMAds shareInstance] getSdkVersion],@"开屏广告显示半屏",@"开屏广告显示全屏",@"信息流广告",@"模版渲染Banner广告",@"模版渲染插屏广告",@"模版渲染激励视频广告"];
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
    if (indexPath.row==0) {
        cell.textLabel.text = [NSString stringWithFormat:@"SDK版本号-%@",[[DMAds shareInstance] getSdkVersion]];
        cell.textLabel.textColor=[UIColor redColor];

    }else{
        cell.textLabel.textColor=[UIColor blackColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
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

    }else if (indexPath.row==1) {
        _isFull = NO;
        self.splashAd = [[DM_SplashAd new] loadSplashAdTemplateAdWithSlotID:@"118171711352274" adSize:CGSizeMake(0, [UIScreen mainScreen].bounds.size.height*0.75) delegate:self];
//        self.splashAd.presentAdViewController = self;
    }else if (indexPath.row==2){
        _isFull = YES;
        self.splashAd = [[DM_SplashAd new] loadSplashAdTemplateAdWithSlotID:@"118171711352274" adSize:CGSizeMake(0, [UIScreen mainScreen].bounds.size.height*0.6) delegate:self];
    }else if (indexPath.row==3){
        FeedAdViewController * feed = [[FeedAdViewController alloc]init];
        [self.navigationController pushViewController:feed animated:YES];
    }else if (indexPath.row==4){
        BannerAdViewController * banner = [[BannerAdViewController alloc]init];
        [self.navigationController pushViewController:banner animated:YES];
    }else if (indexPath.row==5){
        InterstitialAdViewController * interstitial = [[InterstitialAdViewController alloc]init];
        [self.navigationController pushViewController:interstitial animated:YES];
    }else{
        RewardVideoAdViewController * rewardVideo = [[RewardVideoAdViewController alloc]init];
        [self.navigationController pushViewController:rewardVideo animated:YES];
    }
}
-(UIImageView*)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"splash_bottom"]];
        _bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.75, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*0.25);
    }
    return _bottomView;
}
#pragma --DMSplashAdDelegate
- (void)splashAdDidFailToLoadWithError:(nonnull NSError *)error {
    NSLog(@"splashAd加载失败");
    [self.view makeToast:@"splashAd加载失败"
                                     duration:3.0
                position:CSToastPositionCenter];
}

- (void)splashAdDidLoad :(DM_SplashAd*)splashAd;{
    NSLog(@"splashAd加载成功");
    [self.view makeToast:@"splashAd加载成功"
                                     duration:3.0
                position:CSToastPositionCenter];
//    NSArray* crashArr = @[@"0"];
//    NSString *test = [crashArr objectAtIndex:20];
//    int testint = [test intValue];
    [_splashAd biddingSplashSuccess:100];
    [_splashAd biddingSplashFailed:101 Code:DMAdBiddingCodeTimeout];
}
/// 渲染成功
- (void)splashAdDidRender:(DM_SplashAd*)splashAd;{
    // 自定义底部视图
    [self.view makeToast:@"splashAd渲染成功"
                                     duration:3.0
                position:CSToastPositionCenter];
    if (!_isFull) {
        [self.view addSubview: self.bottomView];
    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //然后展示
    [self.view addSubview:splashAd.dmSplashView];
//    [self.splashAd showSplashViewInRootViewController:self];
}
/// 渲染失败
/// - Parameter error: 错误信息
- (void)splashAdDidFailToRenderWithError:(NSError *)error{
    NSLog(@"%@",error);
    NSLog(@"splashAd渲染失败");
    [self.view makeToast:[NSString stringWithFormat:@"splashAd渲染失败--%@",_splashAd.materialId]
                                     duration:3.0
                position:CSToastPositionCenter];
}
/// 广告已经打开
- (void)splashAdDidShow:(DM_SplashAd *)splashAd{
    NSLog(@"splashAd广告已经打开");
    [self.view makeToast:[NSString stringWithFormat:@"plashAd广告已经打开--%@",_splashAd.materialId]
                                     duration:3.0
                position:CSToastPositionCenter];
}
//  广告被点击
- (void)splashAdDidClick:(DM_SplashAd *)splashAd{
    NSLog(@"splashAd广告已经点击");
    [self.view makeToast:[NSString stringWithFormat:@"splashAd广告已经点击--%@",_splashAd.materialId]
                                     duration:3.0
                position:CSToastPositionCenter];
//    [splashAd.dmSplashView removeFromSuperview];
}
//  广告被关闭
- (void)splashAdDidClose:(DM_SplashAd *)splashAd{
    if (!_isFull) {
        [self.bottomView removeFromSuperview];
    }
    NSLog(@"splashAd广告已经关闭");
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view makeToast:[NSString stringWithFormat:@"splashAd广告已经关闭--%@",_splashAd.materialId]
                                     duration:3.0
                position:CSToastPositionCenter];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"%@", dateString);

}
/// 广告详情页关闭回调
- (void)splashAdDetailViewDidClose:(DM_SplashAd *)splashAd{
    NSLog(@"splashAd广告详情页已经关闭");
    [self.view makeToast:[NSString stringWithFormat:@"splashAd广告详情页已经关闭--%@",_splashAd.materialId]
                                     duration:3.0
                position:CSToastPositionCenter];
}
/// 广告详情页将展示回调
- (void)splashAdDetailViewDidPresentScreen:(DM_SplashAd *)splashAd{
    NSLog(@"splashAd广告详情页已经打开");
    [self.view makeToast:[NSString stringWithFormat:@"splashAd广告详情页已经打开--%@",_splashAd.materialId]
                                     duration:3.0
                position:CSToastPositionCenter];
}
@end
