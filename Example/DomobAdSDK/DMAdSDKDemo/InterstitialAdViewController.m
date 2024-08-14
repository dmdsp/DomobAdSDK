//
//  InterstitialAdViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/3/27.
//
//包名：com.sdk.DMAdSDK
//广告位ID：
//118171711352246    ios-信息流
//118171711352274    ios-开屏
//118171711352293    ios-插屏
//118171711352334    ios-
//118171711352643    ios-激励视频--横版
//118171711352679    ios-激励视频--竖版  @刘士林 ios-sdk预发布和线上环境的广告配置了
#import "InterstitialAdViewController.h"
#import "UIView+Toast.h"

#import <DMAdSDK/DM_InterstitialAd.h>
#import <DMAdSDK/DMAds.h>

static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface InterstitialAdViewController ()<UITableViewDelegate,UITableViewDataSource,DMInterstitialAdDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) DM_InterstitialAd * InterstitialAd;
@property (nonatomic, assign) int showCount;
@property (nonatomic, assign) int clickCount;
@end

@implementation InterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showCount = 0;
    _clickCount = 0;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"模版渲染interstitial",@"模版渲染interstitial",@"模版渲染interstitial"];
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
    if (indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"曝光-%d-次",_showCount];
    }else if (indexPath.row == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"点击-%d-次",_clickCount];
    }else{
        cell.textLabel.text = self.titleArr[indexPath.row];
    }    return cell ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        self.InterstitialAd = [[DM_InterstitialAd new] loadInterstitialAdTemplateAdWithSlotID:@"118171711352293"  delegate:self];
        self.InterstitialAd.presentAdViewController = self;

    }else{
        self.InterstitialAd = [[DM_InterstitialAd new] loadInterstitialAdTemplateAdWithSlotID:@"118171711352293"  delegate:self];
    }
}
#pragma  ---DMInterstitialAdDelegate
- (void)interstitialAdDidClick:(nonnull DM_InterstitialAd *)InterstitialAd {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd被点击--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    _clickCount++;
    [self.listTable reloadData];
}
- (void)interstitialAdDidFailToLoadWithError:(nonnull NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd加载失败--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];

}

- (void)interstitialAdDidFailToRenderWithError:(nonnull NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd渲染失败--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}

- (void)interstitialAdDidLoad:(nonnull DM_InterstitialAd *)InterstitialAd {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd加载成功--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    [InterstitialAd biddingInterstitialFailed:1800 Code:DMAdBiddingCodeUnknown];
    [InterstitialAd biddingInterstitialSuccess:10001];
}

- (void)interstitialAdDidRender:(nonnull DM_InterstitialAd *)InterstitialAd {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd渲染成功--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    //渲染成功后已经将view返回
    //可以将view展示在当前的视图上
    self.InterstitialAd = InterstitialAd;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.InterstitialAd showInterstitialViewInRootViewController:self];
}

- (void)interstitialAdDidShow:(nonnull DM_InterstitialAd *)InterstitialAd {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd已经开始展示--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    _showCount++;
    [self.listTable reloadData];
}
/// 广告被关闭
- (void)interstitialAdDidClose:(DM_InterstitialAd *)InterstitialAd{
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd被关闭了--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
