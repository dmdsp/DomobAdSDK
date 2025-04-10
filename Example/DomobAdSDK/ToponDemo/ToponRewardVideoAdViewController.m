//
//  ToponRewardVideoAdViewController.m
//  DMAd
//
//  Created by 刘士林 on 2024/9/10.
//

#import "ToponRewardVideoAdViewController.h"
#import <AnyThinkRewardedVideo/AnyThinkRewardedVideo.h>

#import "UIView+Toast.h"



static NSString *cellWithIdentifier = @"cellWithIdentifier";

@interface ToponRewardVideoAdViewController ()<UITableViewDelegate,UITableViewDataSource,ATRewardedVideoDelegate>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, assign) int showCount;
@property (nonatomic, assign) int clickCount;
@end

@implementation ToponRewardVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:242/255.0 blue:245/255.0 alpha:1.0];;
    self.titleArr= @[@"激励视频"];
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
    NSDictionary *extra = @{
            kATAdLoadingExtraRewardAmountKey:@(3),
        };
        // 加载激励视频广告
        [[ATAdManager sharedManager] loadADWithPlacementID:@"b66dfb56cec2cb" extra:extra delegate:self];
}
#pragma  ---DMRewardVideoAdDelegate
/// Callback when the successful loading of the ad
/// 广告位加载成功
- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID{
    // 展示前需判断广告是否填充
        if ([[ATAdManager sharedManager] rewardedVideoReadyForPlacementID:placementID]) {
            // 广告已填充，展示广告
            [[ATAdManager sharedManager] showRewardedVideoWithPlacementID:placementID inViewController:self delegate:self];
            
            // 带场景ID的展示方法，scene: 场景id
            // [[ATAdManager sharedManager] showRewardedVideoWithPlacementID:@"your rv placementId" scene:@"your rv scene id" inViewController:ViewController delegate:delegate];
        } else {
            // 广告未填充，是否重新加载
        }
}

/// Callback of ad loading failure
/// 广告位加载失败
- (void)didFailToLoadADWithPlacementID:(NSString*)placementID
                                 error:(NSError*)error{
    
}
                                 
/// Rewarded video ad play starts
/// 激励视频开始播放(展示回调)
- (void)rewardedVideoDidStartPlayingForPlacementID:(NSString *)placementID
                                             extra:(NSDictionary *)extra{
    
}

/// Rewarded video ad play ends
/// 激励视频播放完毕
- (void)rewardedVideoDidEndPlayingForPlacementID:(NSString *)placementID
                                           extra:(NSDictionary *)extra{
    
}

/// Rewarded video ad clicks
/// 激励视频广告被点击
- (void)rewardedVideoDidClickForPlacementID:(NSString *)placementID
                                      extra:(NSDictionary *)extra{
    
}

/// Rewarded video ad closed
/// 激励视频广告被关闭
/// rewarded:YES:奖励下发，NO:奖励条件未达成
- (void)rewardedVideoDidCloseForPlacementID:(NSString *)placementID
                                   rewarded:(BOOL)rewarded
                                      extra:(NSDictionary *)extra{
    
}

/// Rewarded video ad reward distribution
/// 激励视频广告奖励下发
- (void)rewardedVideoDidRewardSuccessForPlacemenID:(NSString *)placementID
                                             extra:(NSDictionary *)extra{
    
}
@end

