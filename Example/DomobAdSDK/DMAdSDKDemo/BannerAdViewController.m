//
//  BannerAdViewController.m
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
#import "BannerAdViewController.h"
#import "UIView+Toast.h"

#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DM_BannerAd.h>
#import <DMAdSDK/DM_BannerView.h>
static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface BannerAdViewController ()<UITableViewDelegate,UITableViewDataSource,DMBannerAdDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) DM_BannerAd * bannerAd;

@property (nonatomic, assign) int showCount;
@property (nonatomic, assign) int clickCount;

@end

@implementation BannerAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showCount = 0;
    _clickCount = 0;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"模版渲染banner",@"自渲染banner",@"隐藏反馈视图的banner",@"隐藏反馈视图的banner",@"隐藏反馈视图的banner"];
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
    if (indexPath.row == 3) {
        cell.textLabel.text = [NSString stringWithFormat:@"曝光-%d-次",_showCount];
    }else if (indexPath.row == 4){
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
        self.bannerAd = [[DM_BannerAd new] loadBannerAdTemplateAdWithSlotID:@"118171711352334" popupViewHidden:NO delegate:self];
        self.bannerAd.presentAdViewController = self;

    }else{
        self.bannerAd = [[DM_BannerAd new] loadBannerAdTemplateAdWithSlotID:@"118171711352334" popupViewHidden:YES delegate:self];
    }
}
#pragma  ---DMBannerAdDelegate
- (void)bannerAdDidClick:(nonnull DM_BannerAd *)bannerAd {
    _clickCount ++;
    [self.listTable reloadData];
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd被点击--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}
- (void)bannerAdDidFailToLoadWithError:(nonnull NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd加载失败--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}

- (void)bannerAdDidFailToRenderWithError:(nonnull NSError *)error {
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd渲染失败--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}

- (void)bannerAdDidLoad:(nonnull DM_BannerAd *)bannerAd {
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd加载成功--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    
//    [bannerAd biddingBannerSuccess:10001];
    [bannerAd biddingBannerFailed:1800 Code:DMAdBiddingCodeUnknown];
}

- (void)bannerAdDidRender:(nonnull DM_BannerAd *)bannerAd {
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd渲染成功--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    //渲染成功后已经将view返回
    //可以将view展示在当前的视图上
    self.bannerAd = bannerAd;
    self.bannerAd.bannerView.backgroundColor = [UIColor whiteColor];
    self.bannerAd.bannerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, self.bannerAd.bannerView.bounds.size.width, self.bannerAd.bannerView.bounds.size.height);
    if (self.bannerAd.bannerView.adTemplate == DMBannerAdTemplateCustom) {
        self.bannerAd.bannerView.adLab.text = @"123";
        self.bannerAd.bannerView.closeBtn.hidden = YES;
        self.bannerAd.bannerView.adImageView.frame = self.bannerAd.bannerView.bounds;
        self.bannerAd.bannerView.adLab.frame = CGRectMake(50, 50, 100, 40);
    }

    
    [self.view addSubview:self.bannerAd.bannerView];
}

- (void)bannerAdDidShow:(nonnull DM_BannerAd *)bannerAd {
    _showCount++;
    [self.listTable reloadData];
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd已经开始展示--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}
/// 广告被关闭
- (void)bannerAdDidClose:(DM_BannerAd *)bannerAd{
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd被关闭了--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}

@end
