//
//  DomobInterstitialAdapter.h
//  DMengAdSDK
//
//  Created by 刘士林 on 2024/6/3.
//

#import <Foundation/Foundation.h>
#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DM_Macro.h>
#import <DMAdSDK/DMUnionModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DomobInterstitialManagerDelegate;
@interface DomobInterstitialAdapter : NSObject
typedef void(^DomobInterstitialAdapterCompletion)(DomobInterstitialAdapter * interstitialAdapter);
//广告位id
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;
//当前广告的报价
@property(nonatomic, assign, readonly) long ecpm;

@property(nonatomic, assign, readonly) long originalPrice;
@property (nonatomic , copy) NSString * materialId ;
@property(nonatomic, assign) int64_t bidTs;
@property (nonatomic, strong) DMUnionTrackerModel * trackerModel;
@property (nonatomic, weak) id<DomobInterstitialManagerDelegate> delegate;

/// 初始化插屏广告
/// - Parameter completion: 加载完成后返回的对象
/// - Parameter slotID: 广告位id
- (void)loadInterstitialAdTemplateAdWithSlotID:(nonnull NSString *)slotID completion:(DomobInterstitialAdapterCompletion)completion;
//竞价成功的上报
- (void)biddingInterstitialSuccess:(long)price;
//竞价失败的上报
- (void)biddingInterstitialFailed:(long)price Code:(DMAdBiddingCode)code;
/// 展示广告
/// - Parameter viewController: 当前要展示的控制器
-(void)showInterstitialViewInRootViewController:(UIViewController *)viewController;
-(NSString*)getUnionSdkTracker;
@end

@protocol DomobInterstitialManagerDelegate <NSObject>
/// 加载成功
- (void)interstitialAdDidLoad :(DomobInterstitialAdapter*)interstitialAd;
/// 加载失败
- (void)interstitialAdDidFailToLoadWithError:(NSError *)error;
/// 渲染成功
- (void)interstitialAdDidRender:(DomobInterstitialAdapter*)interstitialAd;;
/// 渲染失败
- (void)interstitialAdDidFailToRenderWithError:(NSError *)error;
/// 广告已经打开
- (void)interstitialAdDidShow:(DomobInterstitialAdapter *)interstitialAd;
/// 广告被点击
- (void)interstitialAdDidClick:(DomobInterstitialAdapter *)interstitialAd;
/// 广告被关闭
- (void)interstitialAdDidClose:(DomobInterstitialAdapter *)interstitialAd;

@end

NS_ASSUME_NONNULL_END
