//
//  DM_RewardVideoAd.h
//  DMAdSDK
//
//  Created by 刘士林 on 2024/3/27.
//

#import <Foundation/Foundation.h>

@protocol DMRewardVideoAdDelegate;
@class DM_RewardVideoView;
@class DM_RewarVideoModel;

NS_ASSUME_NONNULL_BEGIN

@interface DM_RewardVideoAd : NSObject
//广告位id
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;
//当前广告的报价
@property(nonatomic, assign, readonly) long bidPrice;
//竞价成功地址
@property (nonatomic , copy ,readonly)NSArray  * winNoticeUrl ;
//竞价失败地址
@property (nonatomic , copy, readonly) NSArray * lnurl;
//加载广告时的model
@property (nonatomic , strong, readonly) DM_RewarVideoModel * videoModel ;
//使用controller present 落地页
@property (nonatomic, strong) UIViewController *presentAdViewController;


@property (nonatomic , copy) NSString * materialId ;
@property (nonatomic , copy) NSString * rid ;

/// 初始化激励视频和配置、代理
/// - Parameter delegate: 代理
/// - Parameter slotID: 广告位id
/// - Parameter model:  额外的数据
- (instancetype)loadRewardVideoAdTemplateAdWithSlotID:(NSString *)slotID withRewarVideoModel:(DM_RewarVideoModel*)model delegate:(id<DMRewardVideoAdDelegate>)delegate ;
//竞价成功的上报
- (void)biddingRewardVideoSuccess:(long)price;
//竞价失败的上报
- (void)biddingRewardVideoFailed:(long)price Code:(DMAdBiddingCode)code;
/// 展示广告
/// - Parameter viewController: 传入一个控制器
-(void)showRewardVideoViewInRootViewController:(UIViewController *)viewController;

@end

@protocol DMRewardVideoAdDelegate <NSObject>
/// 加载成功
- (void)rewardVideoAdDidLoad :(DM_RewardVideoAd*)rewardVideoAd;
/// 加载失败
- (void)rewardVideoAdDidFailToLoadWithError:(NSError *)error;
/// 渲染成功
- (void)rewardVideoAdDidRender:(DM_RewardVideoAd*)rewardVideoAd;;
/// 渲染失败
- (void)rewardVideoAdDidFailToRenderWithError:(NSError *)error;
/// 广告已经打开
- (void)rewardVideoAdDidShow:(DM_RewardVideoAd *)rewardVideoAd;
/// 广告被点击
- (void)rewardVideoAdDidClick:(DM_RewardVideoAd *)rewardVideoAd;
/// 广告被关闭
- (void)rewardVideoAdDidClose:(DM_RewardVideoAd *)rewardVideoAd;
///播放失败的回调
- (void)rewardVideoAdDidFailToShowWithError:(NSError *)error;
///发奖
- (void)rewardVideoAdDidComplete:(DM_RewardVideoAd *)rewardVideoAd;
///视频播放完成
- (void)rewardVideoAdPlayToEndTime:(DM_RewardVideoAd *)rewardVideoAd;
/// 广告详情页关闭回调
- (void)rewardVideoAdDetailViewDidClose:(DM_RewardVideoAd *)rewardVideoAd;
/// 广告详情页将展示回调
- (void)rewardVideoAdDetailViewDidPresentScreen:(DM_RewardVideoAd *)rewardVideoAd;
@end

NS_ASSUME_NONNULL_END
