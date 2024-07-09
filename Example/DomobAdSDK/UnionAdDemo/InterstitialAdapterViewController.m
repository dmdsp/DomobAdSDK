//
//  InterstitialAdapterViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/6/3.
//

#import "InterstitialAdapterViewController.h"

#import "UIView+Toast.h"

#import <DMAdSDK/DMAds.h>
#import <DomobSDKAdapter/DomobInterstitialManager.h>

static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface InterstitialAdapterViewController ()<UITableViewDelegate,UITableViewDataSource,DomobInterstitialManagerDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) DomobInterstitialAdapter * InterstitialAd;

@end

@implementation InterstitialAdapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"模版渲染interstitial"];
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
        [[DomobInterstitialManager new] loadInterstitialAdTemplateAdWithSlotID:@"118171711352293"  completion:^(DomobInterstitialAdapter * _Nonnull interstitialAdapter) {
            weakself.InterstitialAd = interstitialAdapter;
            interstitialAdapter.delegate = weakself;
        }];
    }else{
        [[DomobInterstitialManager new] loadInterstitialAdTemplateAdWithSlotID:@"118171711352293"  completion:^(DomobInterstitialAdapter * _Nonnull interstitialAdapter) {
            self.InterstitialAd = interstitialAdapter;
            interstitialAdapter.delegate = self;
        }];
    }
}
#pragma  ---DMInterstitialAdDelegate
- (void)interstitialAdDidClick:(nonnull DomobInterstitialAdapter *)InterstitialAd {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd被点击--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
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

- (void)interstitialAdDidLoad:(nonnull DomobInterstitialAdapter *)InterstitialAd {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd加载成功--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    [InterstitialAd biddingInterstitialFailed:1800 Code:DMAdBiddingCodeUnknown];
    [InterstitialAd biddingInterstitialSuccess:10001];
}

- (void)interstitialAdDidRender:(nonnull DomobInterstitialAdapter *)InterstitialAd {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd渲染成功--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    //渲染成功后已经将view返回
    //可以将view展示在当前的视图上
    self.InterstitialAd = InterstitialAd;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.InterstitialAd showInterstitialViewInRootViewController:self];
}

- (void)interstitialAdDidShow:(nonnull DomobInterstitialAdapter *)InterstitialAd {
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd已经开始展示--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
}
/// 广告被关闭
- (void)interstitialAdDidClose:(DomobInterstitialAdapter *)InterstitialAd{
    [self.view makeToast:[NSString stringWithFormat:@"InterstitialAd被关闭了--%@",_InterstitialAd.materialId]
                duration:3.0
                position:CSToastPositionCenter];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
