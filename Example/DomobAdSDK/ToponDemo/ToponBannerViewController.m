//
//  ToponBannerViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/9/9.
//

#import "ToponBannerViewController.h"

#import "UIView+Toast.h"

#import <AnyThinkBanner/AnyThinkBanner.h>

static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface ToponBannerViewController ()<UITableViewDelegate,UITableViewDataSource,ATBannerDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;



@end

@implementation ToponBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"模版渲染banner"];
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
    // 加载广告
    NSDictionary *dict = @{
        // 设置请求的广告尺寸大小，请保持跟后台配置的比例相近
    };
    [[ATAdManager sharedManager] loadADWithPlacementID:@"b66deb6ff548fc" extra:dict delegate:self];
}
#pragma  ---DMBannerAdDelegate
/// Callback when the successful loading of the ad
/// 广告位加载成功
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID{
    // 展示前判断广告是否准备好
     if ([[ATAdManager sharedManager] bannerAdReadyForPlacementID:placementID]) {
             //Retrieve banner view
         ATBannerView *bannerView = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:placementID];
         
         // 带有场景id的获取方式
         // ATBannerView *bannerView = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:@"banner placement id" scene:@"your scene id"];
         
         bannerView.delegate = self;
         bannerView.presentingViewController = self;
         bannerView.frame = CGRectMake(0, 200, self.view.bounds.size.width, 60);
         [self.view addSubview:bannerView];
     } else {

     }
}

/// Callback of ad loading failure
/// 广告位加载失败
- (void)didFailToLoadADWithPlacementID:(NSString*)placementID
                                 error:(NSError*)error{
    
}
                                 
/// BannerView display results
/// 横幅广告位展示了
- (void)bannerView:(ATBannerView *)bannerView didShowAdWithPlacementID:(NSString *)placementID
             extra:(NSDictionary *)extra{
    
}

/// bannerView click
/// 横幅广告位被点击了
- (void)bannerView:(ATBannerView *)bannerView didClickWithPlacementID:(NSString *)placementID
             extra:(NSDictionary *)extra{
    
}
@end
