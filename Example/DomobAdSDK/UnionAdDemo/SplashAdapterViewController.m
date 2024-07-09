//
//  ViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/5/14.
//

#import "SplashAdapterViewController.h"
#import <DomobSDKAdapter/DomobSplashManager.h>
#import <DomobSDKAdapter/DomobAdManager.h>
#import "FeedAdapterViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BannerAdapterViewController.h"
#import "InterstitialAdapterViewController.h"
#import "RewardVideoAdapterViewController.h"

#import "UIView+Toast.h"

static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface SplashAdapterViewController ()<UITableViewDelegate,UITableViewDataSource,DomobSplashManagerDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, assign) bool isFull;
@property (nonatomic, strong) DomobSplashAdapter * splashAd;
@property (nonatomic, strong) UIImageView * bottomView;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation SplashAdapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DomobAdManager shareInstance] initUnionSDKCompletion:^(BOOL success) {
      //在这里去处理初始化成功或失败之后的操作
    }];
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
        kWeakSelf(self);
       [[DomobSplashManager new] loadSplashAdTemplateAdWithSlotID:@"118171711352274" adSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*0.75) completion:^(DomobSplashAdapter * splashAdapter) {
           dispatch_async(dispatch_get_main_queue(), ^{
           weakself.splashAd = splashAdapter;
               weakself.splashAd.delegate = weakself;
               NSLog(@"当前返回的对象为%@",self.splashAd);
           });
        }];
    }else if (indexPath.row==2){
        _isFull = YES;
        [[DomobSplashManager new] loadSplashAdTemplateAdWithSlotID:@"118171711352274" adSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)  completion:^(DomobSplashAdapter * splashAdapter) {
            self.splashAd = splashAdapter;
            self.splashAd.delegate = self;
            NSLog(@"当前返回的对象为%@",self.splashAd);
         }];
    }else if (indexPath.row==3){
        FeedAdapterViewController * feed = [[FeedAdapterViewController alloc]init];
        [self.navigationController pushViewController:feed animated:YES];
    }else if (indexPath.row==4){
        BannerAdapterViewController * banner = [[BannerAdapterViewController alloc]init];
        [self.navigationController pushViewController:banner animated:YES];
    }else if (indexPath.row==5){
        InterstitialAdapterViewController * interstitial = [[InterstitialAdapterViewController alloc]init];
        [self.navigationController pushViewController:interstitial animated:YES];
    }else{
        RewardVideoAdapterViewController * rewardVideo = [[RewardVideoAdapterViewController alloc]init];
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

- (void)splashAdDidLoad :(DomobSplashAdapter*)splashAd{
    NSLog(@"splashAd加载成功");
    [self.view makeToast:@"splashAd加载成功"
                                     duration:3.0
                position:CSToastPositionCenter];
    NSLog(@"splashAd的价格为%ld",splashAd.ecpm);
//    NSArray* crashArr = @[@"0"];
//    NSString *test = [crashArr objectAtIndex:20];
//    int testint = [test intValue];
}
/// 渲染成功
- (void)splashAdDidRender:(DomobSplashAdapter*)splashAd{
    self.splashAd = splashAd;

    // 自定义底部视图
    [self.view makeToast:@"splashAd渲染成功"
                                     duration:3.0
                position:CSToastPositionCenter];
    if (!_isFull) {
        [self.view addSubview: self.bottomView];
    }
    [_splashAd biddingSplashSuccess:100];
    [_splashAd biddingSplashFailed:101 Code:DMAdBiddingCodeTimeout];
    //然后展示
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.splashAd showSplashViewInRootViewController:self];
}
/// 渲染失败
/// - Parameter error: 错误信息
- (void)splashAdDidFailToRenderWithError:(NSError *)error{
    NSLog(@"%@",error);
    NSLog(@"splashAd渲染失败");
    [self.view makeToast:[NSString stringWithFormat:@"splashAd渲染失败--"]
                                     duration:3.0
                position:CSToastPositionCenter];
}
/// 广告已经打开
- (void)splashAdDidShow:(DomobSplashAdapter *)splashAd{
    NSLog(@"splashAd广告已经打开");
    [self.view makeToast:[NSString stringWithFormat:@"plashAd广告已经打开--"]
                                     duration:3.0
                position:CSToastPositionCenter];
}
//  广告被点击
- (void)splashAdDidClick:(DomobSplashAdapter *)splashAd{
    NSLog(@"splashAd广告已经点击");
    [self.view makeToast:[NSString stringWithFormat:@"splashAd广告已经点击--"]
                                     duration:3.0
                position:CSToastPositionCenter];
}
//  广告被关闭
- (void)splashAdDidClose:(DomobSplashAdapter *)splashAd{
    if (!_isFull) {
        [self.bottomView removeFromSuperview];
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    NSLog(@"splashAd广告已经关闭");
    [self.view makeToast:[NSString stringWithFormat:@"splashAd广告已经关闭--"]
                                     duration:3.0
                position:CSToastPositionCenter];
}

@end
