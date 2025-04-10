//
//  ToponInterstitialViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/9/9.
//

#import "ToponInterstitialViewController.h"

#import "UIView+Toast.h"

#import <DMAdSDK/DM_InterstitialAd.h>
#import <DMAdSDK/DMAds.h>
#import <AnyThinkInterstitial/AnyThinkInterstitial.h>

static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface ToponInterstitialViewController ()<UITableViewDelegate,UITableViewDataSource,ATInterstitialDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) DM_InterstitialAd * InterstitialAd;
@property (nonatomic, assign) int showCount;
@property (nonatomic, assign) int clickCount;
@end

@implementation ToponInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showCount = 0;
    _clickCount = 0;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"渲染interstitial",];
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
    [[ATAdManager sharedManager] loadADWithPlacementID:@"b66d967d6c5959" extra:nil delegate:self];
}

/// Callback when the successful loading of the ad
/// 广告位加载成功
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID{
    // 展示前需判断广告是否填充
        if ([[ATAdManager sharedManager] interstitialReadyForPlacementID:placementID]) {
            // 广告已填充，展示广告
            [[ATAdManager sharedManager] showInterstitialWithPlacementID:placementID inViewController:self delegate:self];
            
            // 带场景ID的展示方法，scene: 场景id
            // [[ATAdManager sharedManager] showInterstitialWithPlacementID:@"your in placementId" scene:@"your in scene id" inViewController:ViewController delegate:delegate];
        } else {
            // 广告未填充，是否重新加载
        }
}

/// Callback of ad loading failure
/// 广告位加载失败
- (void)didFailToLoadADWithPlacementID:(NSString*)placementID
                                 error:(NSError*)error{
    
}
                                 
/// Interstitial ad displayed successfully
/// 插屏广告展示成功
- (void)interstitialDidShowForPlacementID:(NSString *)placementID
                                    extra:(NSDictionary *)extra{
    
}

/// Interstitial ad clicked
/// 插屏广告被点击了
- (void)interstitialDidClickForPlacementID:(NSString *)placementID
                                     extra:(NSDictionary *)extra{
    
}

/// Interstitial ad closed
/// 插屏广告被关闭了
- (void)interstitialDidCloseForPlacementID:(NSString *)placementID
                                     extra:(NSDictionary *)extra{
    
}
@end
