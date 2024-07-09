//
//  DomobRewardedVideoAdapter.h
//  DMengAdSDK
//
//  Created by 刘士林 on 2024/6/4.
//

#import <Foundation/Foundation.h>
#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DM_Macro.h>
#import <DMAdSDK/DMUnionModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DomobRewardedVideoManagerDelegate;
@class DomobRewardVideoModel;
@interface DomobRewardedVideoAdapter : NSObject
typedef void(^DomobRewardedVideoAdapterCompletion)(DomobRewardedVideoAdapter * rewardedVideoAdapter);
//广告位id
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;
//当前广告的报价
@property(nonatomic, assign, readonly) long ecpm;
//加载广告时的model
@property (nonatomic , strong) DomobRewardVideoModel * rewardModel ;
@property(nonatomic, assign, readonly) long originalPrice;
@property (nonatomic , copy) NSString * materialId ;
@property(nonatomic, assign) int64_t bidTs;
@property (nonatomic, strong) DMUnionTrackerModel * trackerModel;
@property (nonatomic, weak) id<DomobRewardedVideoManagerDelegate> delegate;

/// 初始化激励视频和配置、代理
/// - Parameter delegate: 代理
/// - Parameter slotID: 广告位id
/// - Parameter model:  额外的数据
- (void)loadRewardedVideoAdTemplateAdWithSlotID:(NSString *)slotID withRewardVideoModel:(DomobRewardVideoModel*)model completion:(DomobRewardedVideoAdapterCompletion)completion;
//竞价成功的上报
- (void)biddingRewardedVideoSuccess:(long)price;
//竞价失败的上报
- (void)biddingRewardedVideoFailed:(long)price Code:(DMAdBiddingCode)code;
/// 展示广告
/// - Parameter viewController: 当前要展示的控制器
-(void)showRewardedVideoViewInRootViewController:(UIViewController *)viewController;
-(NSString*)getUnionSdkTracker;
@end

@protocol DomobRewardedVideoManagerDelegate <NSObject>
/// 加载成功
- (void)rewardVideoAdDidLoad :(DomobRewardedVideoAdapter*)rewardVideoAd;
/// 加载失败
- (void)rewardVideoAdDidFailToLoadWithError:(NSError *)error;
/// 渲染成功
- (void)rewardVideoAdDidRender:(DomobRewardedVideoAdapter*)rewardVideoAd;;
/// 渲染失败
- (void)rewardVideoAdDidFailToRenderWithError:(NSError *)error;
/// 广告已经打开
- (void)rewardVideoAdDidShow:(DomobRewardedVideoAdapter *)rewardVideoAd;
/// 广告被点击
- (void)rewardVideoAdDidClick:(DomobRewardedVideoAdapter *)rewardVideoAd;
/// 广告被关闭
- (void)rewardVideoAdDidClose:(DomobRewardedVideoAdapter *)rewardVideoAd;
///播放失败的回调
- (void)rewardVideoAdDidFailToShowWithError:(NSError *)error;
///发奖
- (void)rewardVideoAdDidComplete:(DomobRewardedVideoAdapter *)rewardVideoAd;
///视频播放完成
- (void)rewardVideoAdPlayToEndTime:(DomobRewardedVideoAdapter *)rewardVideoAd;
@end

NS_ASSUME_NONNULL_END
