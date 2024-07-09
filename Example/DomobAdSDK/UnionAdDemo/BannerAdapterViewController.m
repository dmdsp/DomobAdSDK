//
//  BannerAdapterViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/5/30.
//

#import "BannerAdapterViewController.h"

#import "UIView+Toast.h"

#import <DMAdSDK/DMAds.h>
#import <DomobSDKAdapter/DomobBannerManager.h>
static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface BannerAdapterViewController ()<UITableViewDelegate,UITableViewDataSource,DomobBannerManagerDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) DomobBannerAdapter * bannerAd;

@end

@implementation BannerAdapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"模版渲染banner",@"自渲染banner",@"隐藏反馈视图的banner"];
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
        [[DomobBannerManager new] loadBannerAdTemplateAdWithSlotID:@"118171711352334" popupViewHidden:NO completion:^(DomobBannerAdapter * _Nonnull bannerAdapter) {
            weakself.bannerAd = bannerAdapter;
            weakself.bannerAd.delegate = weakself;
        }];
    }else{
        [[DomobBannerManager new] loadBannerAdTemplateAdWithSlotID:@"118171711352334" popupViewHidden:YES completion:^(DomobBannerAdapter * _Nonnull bannerAdapter) {
            self.bannerAd = bannerAdapter;
            self.bannerAd.delegate = self;
        }];
    }
}
#pragma  ---DMBannerAdDelegate
- (void)bannerAdDidClick:(nonnull DomobBannerAdapter *)bannerAd {
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

- (void)bannerAdDidLoad:(nonnull DomobBannerAdapter *)bannerAd {
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd加载成功--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    
//    [bannerAd biddingBannerSuccess:10001];
    [bannerAd biddingBannerFailed:1800 Code:DMAdBiddingCodeUnknown];
}

- (void)bannerAdDidRender:(nonnull DomobBannerAdapter *)bannerAd {
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd渲染成功--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    //渲染成功后已经将view返回
    //可以将view展示在当前的视图上
    self.bannerAd = bannerAd;
    self.bannerAd.bannerView.backgroundColor = [UIColor whiteColor];
    self.bannerAd.bannerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, self.bannerAd.bannerView.bounds.size.width, self.bannerAd.bannerView.bounds.size.height);
    [self.view addSubview:self.bannerAd.bannerView];
}

- (void)bannerAdDidShow:(nonnull DomobBannerAdapter *)bannerAd {
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd已经开始展示--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}
/// 广告被关闭
- (void)bannerAdDidClose:(DomobBannerAdapter *)bannerAd{
    [self.view makeToast:[NSString stringWithFormat:@"bannerAd被关闭了--%@",_bannerAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}

@end
